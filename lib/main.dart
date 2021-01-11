import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'screens/intro/splash.dart';
import 'services/helpers.dart';

void main() async {
  runApp(Sharpie());
  var date = new DateTime.now().toString();
  var dateParse = DateTime.parse(date);
  final storage = new FlutterSecureStorage();
  MashovHelper().saveLogin(
    await storage.read(key: "mashovUsername"),
    await storage.read(key: "mashovPassword"),
    "540484",
    dateParse.year.toString(),
  );
}

class Sharpie extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Splash();
}
