import 'package:flutter/material.dart';
import 'grades.dart';
import 'navBar.dart';

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
      bottomNavigationBar: NavBar(index: 1),
    ));
  }
}
