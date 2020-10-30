import 'package:flutter/material.dart';
import 'package:sharpie_app/services/preferences.dart';
void main() async{ 
  runApp(MyApp());
  //Added check to main to see if the isFirst() function works. This returns the text "Instance of Future<bool>"
  //which is a problem because i just want to know the value of the bool.
  Preferences _prefs = new Preferences();
  bool iF = await _prefs.isFirst();
  print(iF);
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Sharpie",
      home : Scaffold (
        appBar : AppBar(
          title: Text("Sharp"),
            ),
        body: Center(
          child: Text("Hello zain", style: TextStyle(color: Colors.blue[200]),),
          ),
        ),
      );
  }
}

