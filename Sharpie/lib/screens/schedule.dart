import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

// class lesson for future use idk
class Lesson {
  String desc;
  String time;
}
class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
     // what we'll actually do instead of [1,2,3,4,5] is make a list<lesson> and feed this sexy animal with data from artyeshiva
    var lessons = [1, 2, 3, 4, 5, 6];
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        // container naturally takes all the width so i had to wrap with align
        return Align(child :Container(
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        ));
      },
    );
  }
}
