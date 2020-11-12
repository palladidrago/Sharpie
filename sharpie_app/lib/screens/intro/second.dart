import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharpie_app/services/preferences.dart';

SharedPreferences sp;

void main() async {
  runApp(new MyWidget());
}

class MyWidget extends StatelessWidget {
  final String title = "fuck me";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(sp.getString("key")),
        ),
      ),
    );
  }
}
//Add here the class that returns the second page, with the choice for subjects.
