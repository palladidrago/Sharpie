import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//Self imports//
import 'schedule.dart';
import 'grades.dart';
import 'settings.dart';
import 'homework.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tabs = [
    Schedule(),
    GradePage(),
    Homework(),
    Settings(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Page",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          unselectedItemColor: Colors.grey[600],
          selectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (int tappedIndex) {
            setState(() {
              _currentIndex = tappedIndex;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: "Grades",
              icon: Icon(Icons.assessment_outlined),
            ),
            BottomNavigationBarItem(
              label: "Homework",
              icon: Icon(Icons.school_outlined),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
