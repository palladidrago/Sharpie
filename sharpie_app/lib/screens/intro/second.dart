import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharpie_app/services/assets.dart';

void main() async => runApp(new SecondPage());

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Josefin",
        scaffoldBackgroundColor: Colors.blue[300],
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: GetName(),
              ),
              Container(
                height: screenHeight * .725,
                margin: const EdgeInsets.all(35.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red[300],
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GetName extends StatefulWidget {
  @override
  _GetNameState createState() => _GetNameState();
}

class _GetNameState extends State<GetName> {
  Future<String> _getName;

  @override
  void initState() {
    _getName = SharedPreferences.getInstance()
        .then((prefs) => prefs.getString("Name"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getName,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // The value is not read yet
            return Text("Loading username...");
          }

          final name = snapshot.data.toString();
          return Text("Hello $name");
        });
  }
}
