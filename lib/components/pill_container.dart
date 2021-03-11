import 'package:flutter/material.dart';

class ScheduleComponent extends StatefulWidget {
  ScheduleComponent({
    Key key,
    this.leftUp,
    this.leftDown,
    this.rightUp,
    this.rightDown,
  }) : super(key: key);

  final String leftUp;
  final String leftDown;
  final String rightUp;
  final String rightDown;

  @override
  _ScheduleComponentState createState() => _ScheduleComponentState();
}

class _ScheduleComponentState extends State<ScheduleComponent> {
  //Contains the raw schedule
  @override
  Widget build(BuildContext context) {
    return Container(
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
                widget.leftUp,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.leftDown,
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
                widget.rightUp,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey),
              ),
              Text(
                widget.rightDown,
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
    );
  }
}
