import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sharpie/services/assets.dart';
import '../../services/mac_credentials.dart' as credentials;

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
  //Contains the raw schedule
  @override
  Widget build(BuildContext context) {
    //Make a list<lesson> and feed it with data from artyeshiva
    var lessons = [1, 2, 3, 4, 5, 6];
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        // container naturally takes all the width so i had to wrap with align
        return Align(
          child: Container(
            // the time will be lessons[index].time, the class description will be lessons[index].desc
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 30),
            height: 75,
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              color: Color(0xFFF9F9FB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "8:45",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "AM",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  // the line seperating time of lesson and description
                  height: 75,
                  width: 1,
                  color: Colors.grey.withOpacity(0.5),
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "מתמטיקה(5)",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey),
                    ),
                    Text(
                      "המורה אירנה {יא1,יא2}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
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
          credentials.user_name, credentials.password, "540484", "2021");
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
