import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

//Returns if it's the first time the app is being used.
//it has to return Future<bool> because it uses async and SharedPreferences needs async.
//Todo: put this function inside a class

class Preferences {
  static SharedPreferences _prefs;

  static Future<bool> isFirst() async {
    //Returs if this is the first run of the app.
    _prefs = await SharedPreferences.getInstance();
    bool isFirst = _prefs.getBool("fr") == null;
    _prefs.setBool("fr", false);
    return isFirst;
  }

  static void setName(String name) async {
    _prefs.setString("Name", name);
  }

  setStringValue(String key, String value) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key, value);
  }

  static Future<String> getName() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString("Name");
  }

  Future<String> getStringValue(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key) ?? "";
  }

  Future<bool> containsKey(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.containsKey(key);
  }

  removeValue(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.remove(key);
  }

  removeAll() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.clear();
  }
}
