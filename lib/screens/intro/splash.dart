import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharpie_app/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sharpie_app/services/assets.dart';
import 'mashov_credentials.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        fontFamily: "Josefin",
      ),
      home: SplashScreen(
        //TODO: Use navigateAfterFuture instead of the mess i made down there.
        seconds: 2,
        routeName: "/",
        navigateAfterSeconds: SecondScreen(),
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

class SecondScreen extends StatelessWidget {
  static Future<bool> isLogged() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // _prefs.setBool("isLogged", false);
    var iL = _prefs.getBool("isLogged");
    if (iL == false || iL == null) {
      return false;
    } else if (iL == true) {
      return true;
    }
    return false;
  }

  final Future<bool> logged = isLogged();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: logged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.data == true) {
          return HomePage();
        } else if (snapshot.data == false) {
          return MashovCredentials();
        } else
          return Text("ERROR");
      },
    );
  }
}
