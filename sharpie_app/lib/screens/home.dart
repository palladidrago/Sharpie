import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Actual home page.
//What is the layout for this page?

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Image(image: AssetImage('graphics/background.png'));
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Josefin",
        scaffoldBackgroundColor: Colors.red[300],
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              GetFuture(),
            ],
          ),
        ),
      ),
    );
  }
}

class GetFuture extends StatefulWidget {
  @override
  _GetFutureState createState() => _GetFutureState();
}

class _GetFutureState extends State<GetFuture> {
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('name') ?? '');
      _password = (prefs.getString('password') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        "id: $_email, pass: $_password.",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
