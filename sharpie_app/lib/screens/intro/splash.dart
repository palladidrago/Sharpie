import 'package:flutter/material.dart';
import 'package:sharpie_app/screens/intro/mashov_credentials.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sharpie_app/services/assets.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        fontFamily: "Josefin",
      ),
      home: SplashScrn(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScrn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 1,
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
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MashovCredentials();
}
