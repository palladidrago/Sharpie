import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'mashov_credentials.dart';
import '../homepage/home.dart';

class Splash extends StatelessWidget {
  Splash({Key key, this.setIsLogged = true}) : super(key: key);

  final bool setIsLogged;

  Future<Widget> nextPage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (!this.setIsLogged) {
      _prefs.setBool("isLogged", false);
    }
    var iL = _prefs.getBool("isLogged");
    if (iL == false || iL == null) {
      return MashovCredentials();
    } else if (iL == true) {
      //Add login for loading.
      return Home();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        fontFamily: "Josefin",
      ),
      home: SplashScreen(
        seconds: 1,
        navigateAfterFuture: nextPage(),
        routeName: "/",
        gradientBackground: Gradient.lerp(
          LinearGradient(
            colors: [
              Colors.red[300],
              Colors.blue[300],
            ],
          ),
          LinearGradient(
            colors: [
              Colors.red[300],
              Colors.blue[300],
            ],
          ),
          0.5,
        ),
        image: Image.asset(
          'assets/SharpieText.png',
          fit: BoxFit.cover,
        ),
        loadingText: Text("Loading"),
        photoSize: 150.0,
        loaderColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
