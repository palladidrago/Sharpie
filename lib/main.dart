import 'package:flutter/material.dart';
import 'package:sharpie_app/screens/intro/splash.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sharpie_app/services/preferences.dart';

void main() async {
  runApp(Sharpie());
}

class Sharpie extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Splash();
}
