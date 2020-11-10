import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  String name = "bro";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sharpie",
      home: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                child: Center(
                  child: Text(
                    "Hi $name",
                    style: TextStyle(/*style this shit*/),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Hi $name",
                  textAlign: TextAlign.center,
                  style: TextStyle(/*style this shit*/),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
