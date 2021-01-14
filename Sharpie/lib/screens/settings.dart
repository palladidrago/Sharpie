//The settings live here.
import 'package:flutter/material.dart';
import 'navBar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(child:Text("debora alay LOL")),
      bottomNavigationBar: NavBar(index: 2),
    ));
  }
}
