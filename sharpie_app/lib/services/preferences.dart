import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

//Returns if it's the first time the app is being used.
//it has to return Future<bool> because it uses async and SharedPreferences needs async.
//Todo: put this function inside a class

class Preferences {
  static Preferences _storageUtil;
  static SharedPreferences _prefs;

  static Future<bool> isFirst() async {
    //Returs if this is the first run of the app.
    _prefs = await SharedPreferences.getInstance();
    bool isFirst = _prefs.getBool("fr") == null;
    _prefs.setBool("fr", false);
    return isFirst;
  }

  static Future<Preferences> getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = Preferences._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  Preferences._();
  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // sets string
  static Future<void> setString(String key, String value) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.setString(key, value);
  }

  Future<bool> containsKey(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.containsKey(key);
  }

  static removeValue(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.remove(key);
  }

  static removeAll() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.clear();
  }
}
