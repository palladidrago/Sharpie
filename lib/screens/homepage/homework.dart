import 'package:flutter/material.dart';
import '/services/database.dart';
import '/components/pill_container.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Homework extends StatefulWidget {
  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  static var _homework = FirestoreDB.getCollectionData("homework");

  static var homeworks = _homeworks();
  static Future<List<dynamic>> _homeworks() async {
    var homework = await _homework;
    Map<String, dynamic> homeworks = {};

    homework.forEach((data) {
      homeworks = data.data();
    });

    return FirestoreDB.getDataAsList(homeworks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<List<dynamic>>(
          future: homeworks,
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              var homework = snapshot.data;
              return Text(
                "${homework.length} שיעורי בית להיום",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textDirection: TextDirection.rtl,
              );
            } else if (snapshot.hasError) {
              return Text("Error");
            } else {
              return Text("Loading...");
            }
          },
        ),
        backgroundColor: Colors.grey[400],
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: FutureBuilder<List<dynamic>>(
          future: homeworks,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var homework = snapshot.data;

              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: ListView.builder(
                  itemCount: homework.length,
                  itemBuilder: (context, index) {
                    try {
                      return Container(
                        child: PillComponent(
                          rightUp: homework[index][1],
                          leftUp: homework[index][0],
                          rightDown: "",
                          leftDown: "",
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10),
                      );
                    } catch (e) {
                      if (index < 1) {
                        return Text(e.toString());
                      } else {
                        return null;
                      }
                    }
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            } else {
              return SpinKitDoubleBounce(color: Colors.blue.withOpacity(0.3));
            }
          },
        ),
      ),
    );
  }
}
