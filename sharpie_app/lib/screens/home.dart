import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Actual home page.
//What is the layout for this page?

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage('graphics/background.png'));
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
