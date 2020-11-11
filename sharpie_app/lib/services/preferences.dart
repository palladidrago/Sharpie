import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

//Returns if it's the first time the app is being used.
//it has to return Future<bool> because it uses async and SharedPreferences needs async.
//Todo: put this function inside a class

class Preferences {
  Future<bool> isFirst() async {
    //Returs if this is the first run of the app.
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool isFirst = _prefs.getBool("fr") == null;
    _prefs.setBool("fr", false);
    return isFirst;
  }

  static void setName(String name) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("Name", name);
  }

  static Future<String> getName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("Name");
  }
}
