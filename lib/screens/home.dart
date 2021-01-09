import 'package:flutter/material.dart';
import 'grades.dart';
//Actual home page.
//What is the layout for this page?

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sharpie",
      theme: ThemeData(
        fontFamily: "Josefin",
        scaffoldBackgroundColor: Colors.red[300],
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              GradeList(),
            ],
          ),
        ),
      ),
    );
  }
}
