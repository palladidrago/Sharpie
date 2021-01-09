import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharpie_app/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sharpie_app/services/assets.dart';
import 'mashov_credentials.dart';

class Splash extends StatelessWidget {
  static Future<Widget> nextPage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // _prefs.setBool("isLogged", false);
    var iL = _prefs.getBool("isLogged");
    if (iL == false || iL == null) {
      return MashovCredentials();
    } else if (iL == true) {
      //Add login for loading.
      return HomePage();
    }
    return null();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        fontFamily: "Josefin",
      ),
      home: SplashScreen(
        navigateAfterFuture: Splash.nextPage(),
        seconds: 100,
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
        image: Image(
          image: AssetImage(Images.logoTLoc),
        ),
        loadingText: Text("Loading"),
        photoSize: 150.0,
        loaderColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
