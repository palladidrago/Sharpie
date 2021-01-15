import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:requests/requests.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic getTestFromKita(int kita) async {
  final String artRssLink = 'https://art-yeshiva.org.il/WS/RssEvents.aspx';
  //Returns the latest test for given kita
  //kita- number from 7 - 12(ז-ח) +0+ First class or second (example: ז1=701 ,יא1=1101)
  var artRssRawR = await Requests.get("$artRssLink?kita=${kita.toString()}");
  String artRssRaw = artRssRawR.content();
  var artRss = RssFeed.parse(artRssRaw).items.first;
  //Todo: this only works if there is one hakbatza for the test, but if there is more than 1
  //you need to find a way to take the right item based on it.
  return artRss; // An RssFeed object.
}

final _sStorage = FlutterSecureStorage();

void mashovLoginSave(String username, String password,
    [String semel = "540484", String year]) async {
  //Logs into the mashov, saves credentials to phone secure storage( username and pass are necessary, semel and year default to
  //Bar-Ilan and current year)
  final _prefs = await SharedPreferences.getInstance();

  final now = DateTime.now();
  int realYear = now.year;
  if (now.month > 8 /*August*/)
    realYear++; //The year needs to be current year plus one if it's after august.
  year = year ??
      realYear
          .toString(); // year is the paramater if it's not null, is realYear if it is.

  await _sStorage.write(key: 'mashovUsername', value: username);
  await _sStorage.write(key: 'mashovPassword', value: password);
  await _sStorage.write(key: 'mashovSemel', value: semel);
  await _sStorage.write(key: 'mashovYear', value: year);
  await _prefs.setBool('isLogged', true); //Saves logged state to phone
}

Future<String> getMashovUsername() {
  return _sStorage.read(key: 'mashovUsername');
}

Future<String> getMashovPassword() async {
  return await _sStorage.read(key: 'mashovPassword');
}

String getMashovYear() {
  //Returns the current year that the mashov wants.
  final now = DateTime.now();
  int realYear = now.year;
  if (now.month > 8 /*August*/)
    realYear++; //The year needs to be current year plus one if it's after august.
  return realYear.toString();
}
//TODO: make function that validates mashov credentials.

//Helps you with screen sizes
Size displaySize(BuildContext context) {
//Returns the size of the display
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
//Returns height of the display
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
//Returns width of the display
  return displaySize(context).width;
}