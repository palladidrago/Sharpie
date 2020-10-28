import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

//Returns if it's the first time the app is being used.
//it has to return Future<bool> because it uses async and SharedPreferences needs async. Idk how to use that future
//later.
//Todo: put this function inside a class and figure out how to return a proper bool

Future<bool> isFirst() async 
{
  SharedPreferences  _prefs = await SharedPreferences.getInstance(); 
  bool isFirst = _prefs.getBool("firstrun") ?? true;
  return isFirst == null;

}

