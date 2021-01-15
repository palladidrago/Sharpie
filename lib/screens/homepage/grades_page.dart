import 'package:flutter/material.dart';
//Self imports
import 'package:sharpie/screens/homepage/grades.dart';
import 'package:sharpie/screens/homepage/navbar.dart';

class GradesPage extends StatefulWidget {
  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  //Wrapper for grade page with navbar
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: GradeList(),
      bottomNavigationBar: NavBar(index: 1),
    ));
  }
}
