import 'package:flutter/material.dart';

class PillComponent extends StatefulWidget {
  PillComponent({
    Key key,
    @required this.rightUp,
    @required this.leftUp,
    this.rightDown,
    this.leftDown,
  }) : super(key: key);

  final String rightUp;
  final String leftUp;
  final String rightDown;
  final String leftDown;

  @override
  _PillComponentState createState() => _PillComponentState();
}

class _PillComponentState extends State<PillComponent> {
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
                  fontSize: 25,
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
