import 'package:flutter/material.dart';
import 'screens/intro/splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load();
  runApp(Sharpie());
}

class Sharpie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}
