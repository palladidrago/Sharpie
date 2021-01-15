//The settings live here.
import 'package:flutter/material.dart';
import 'package:sharpie/screens/homepage/navbar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(child:Text("Settings")),
      bottomNavigationBar: NavBar(index: 2),
    ));
  }
}
