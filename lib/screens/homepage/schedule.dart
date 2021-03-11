import 'dart:io' show Platform;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../components/pill_container.dart';
import 'package:intl/intl.dart' as format;
import '../../services/assets.dart';
import '../../services/database.dart';

// class Lesson {
//   String desc;
//   String time;
// }

//We should merge the 2 schedule classes.

class ScheduleRaw extends StatefulWidget {
  @override
  _ScheduleRawState createState() => _ScheduleRawState();
}

class _ScheduleRawState extends State<ScheduleRaw> {
  static var _schedule = FirestoreDB.getDocumentData(
    "schedule",
    format.DateFormat('EEEE').format(DateTime.now()).toLowerCase(),
  );

  //Contains the raw schedule
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
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

          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              // container naturally takes all the width so i had to wrap with align
              return Align(
                child: ScheduleComponent(
                  leftUp: "${subject[index][1]}",
                  leftDown: "AM",
                  rightUp: "${subject[index][0]}",
                  rightDown: "${subject[index][2]}",
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Text("No data");
        }
        return SpinKitDoubleBounce(color: Colors.red.withOpacity(0.3));
      },
    );
  }
}

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
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
    return MaterialApp(
      title: "Home",
      theme: ThemeData(
        fontFamily: "Josefin",
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFD4E7FE),
                    Color(0xFFF9F9FB),
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(Images.logoLoc),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FutureBuilder<Name>(
                            future: _name,
                            builder: (BuildContext context,
                                AsyncSnapshot<Name> snapshot) {
                              if (snapshot.hasData) {
                                var name = snapshot.data;
                                return Text(
                                  "שלום!\n${name.firstName} ${name.lastName}",
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
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "👇 מערכת להיום מוצגת למטה",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF343E87),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 160,
              child: Container(
                height: MediaQuery.of(context).size.height - 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ScheduleRaw(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
