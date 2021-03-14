import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../components/pill_container.dart';
import 'package:intl/intl.dart' as format;
import '../../services/database.dart';

// class Lesson {
//   String desc;
//   String time;
// }

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  static var _schedule = FirestoreDB.getDocumentData(
    "schedule",
    format.DateFormat('EEEE').format(DateTime.now()).toLowerCase(),
  );

  var _name = _getName(); //Saves list of grades in variable
  static Future<Name> _getName() async {
    //Returns list of grades.
    var mashovController = Controller();
    final storage = new FlutterSecureStorage();
    if (!Platform.isMacOS) {
      await mashovController.login(await storage.read(key: "mashovUsername"),
          await storage.read(key: "mashovPassword"), "540484", "2021");
    } else {
      await mashovController.login(
          env['USERNAME'], env['PASSWORD'], "540484", "2021");
    }
    return await mashovController.getName(); //Returns list of Grades
  }

  @override
  Widget build(BuildContext context) {
    var hour = DateTime.now().hour;
    var greetings;
    if (hour >= 7 && hour < 12) {
      greetings = "בוקר טוב";
    } else if (hour >= 12 && hour < 18) {
      greetings = "צהריים טובים";
    } else if (hour >= 18 && hour <= 23) {
      greetings = "ערב טוב";
    } else {
      greetings = "לילה טוב";
    }

    return Stack(
      children: <Widget>[
        Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[100],
                Colors.lightBlue[50],
                Colors.grey[200],
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(55),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 25),
                    child: Image.asset(
                      'assets/Sharpie.png',
                      height: 85,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 40, right: 100),
                    child: Column(
                      children: <Widget>[
                        FutureBuilder<Name>(
                          future: _name,
                          builder: (BuildContext context,
                              AsyncSnapshot<Name> snapshot) {
                            if (snapshot.hasData) {
                              var name = snapshot.data;
                              return Text(
                                "$greetings\n${name.firstName} ${name.lastName}",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue[900],
                                  //Color(0XFF343E87
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("Error");
                            } else {
                              return Text('Awaiting result...');
                            }
                          },
                        ),
                        Text(
                          "👇 מערכת להיום מוצגת למטה",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF343E87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        FutureBuilder<DocumentSnapshot>(
          future: _schedule,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<dynamic> subject = [];
              var schedule = snapshot.data.data();
              //Make a list<lesson> and feed it with data from artyeshiva
              var lessons = List.filled(schedule.length, []);
              var iterator = schedule.values.iterator;
              while (iterator.moveNext()) {
                var curr = iterator.current;
                subject.add(curr.toString().split(','));
              }

              return Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  top: 160,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    try {
                      return Container(
                        child: ScheduleComponent(
                          rightUp: "${subject[index][0]}",
                          leftUp: "${subject[index][1]}",
                          rightDown: "${subject[index][2]}",
                          leftDown: "AM",
                          rightUpSize: 25,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10),
                      );
                    } catch (e) {
                      return Container(
                        child: ScheduleComponent(
                          rightUp: e.toString(),
                          leftUp: "Error",
                          rightDown: "",
                          leftDown: "",
                          rightUpSize: 15,
                        ),
                      );
                    }
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return SpinKitDoubleBounce(color: Colors.red.withOpacity(0.3));
          },
        ),
      ],
    );
  }
}
