import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'screens/intro/splash.dart';
// import 'services/helpers.dart';

void main() async {
  runApp(Sharpie());
  // var date = new DateTime.now().toString();
  // var dateParse = DateTime.parse(date);
  var mashovController = Controller();
  final storage = new FlutterSecureStorage();
  await mashovController.login(await storage.read(key: "mashovUsername"),
      await storage.read(key: "mashovPassword"), "540484", "2021");
}

class Sharpie extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Splash();
}
