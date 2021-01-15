import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//Self imports//
import 'package:sharpie/screens/homepage/schedule.dart';
import 'package:sharpie/screens/homepage/grades.dart';
import 'package:sharpie/screens/homepage/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tabs = [
    Schedule(),
    GradePage(),
    Settings(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Color(0xFFF9F9FB),
          unselectedItemColor: Colors.grey,
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
              label: "",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.assessment_outlined),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
