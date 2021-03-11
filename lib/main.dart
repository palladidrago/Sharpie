import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/intro/splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DotEnv.load();
  runApp(Sharpie());
}

class Sharpie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // to run mashov_credentials page even though we're already logged in:
    // comment this line
    return Splash();
    // uncomment this line
    // return Splash(setIsLogged: false);
  }
}
