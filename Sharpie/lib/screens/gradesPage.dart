import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'grades.dart';

class GradesPage extends StatefulWidget {
  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: GradeList(),
    ));
  }
}
