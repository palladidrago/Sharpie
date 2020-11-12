import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharpie_app/services/preferences.dart';

void main() async => runApp(new SecondPage());

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text("Hello $name"),
                  )
                ],
              ),
            ),
          );
        });
  }
}
