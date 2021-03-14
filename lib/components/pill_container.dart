import 'package:flutter/material.dart';

class ScheduleComponent extends StatefulWidget {
  ScheduleComponent(
      {Key key,
      this.rightUp,
      this.leftUp,
      this.rightDown,
      this.leftDown,
      this.rightUpSize})
      : super(key: key);

  final String rightUp;
  final String leftUp;
  final String rightDown;
  final String leftDown;
  final double rightUpSize;

  @override
  _ScheduleComponentState createState() => _ScheduleComponentState();
}

class _ScheduleComponentState extends State<ScheduleComponent> {
  //Contains the raw schedule
  @override
  Widget build(BuildContext context) {
    return Container(
      // the time will be lessons[index].time, the class description will be lessons[index].desc
      decoration: BoxDecoration(
        color: Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[300],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                widget.leftUp,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.leftDown,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            // the line seperating time of lesson and description
            height: 75,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Column(
            children: <Widget>[
              Text(
                widget.rightUp,
                style: TextStyle(
                  fontSize: widget.rightUpSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey,
                ),
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
