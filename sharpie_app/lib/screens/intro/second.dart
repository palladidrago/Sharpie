import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async => runApp(new SecondPage());
//Todo: dropdownbox for kita, save to sharedpreferences in this format '7-12'0'1-2'
//For example ז1=701
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenWidth = MediaQuery.of(context).size.width;

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
                width: screenWidth * 7,
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
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(screenHeight * .1),
                      child: Dropdown(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dropdown extends StatefulWidget {
  Dropdown({Key key}) : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownState extends State<Dropdown> {
  String dropdownValue = 'א׳1';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.red[300],
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        isDense: true,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
        iconSize: 21,
        elevation: 16,
        style: TextStyle(
          color: Colors.white,
        ),
        underline: Container(
          height: 2,
          color: Colors.black,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['א׳1', 'א׳2', 'א׳3', 'ב׳']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        }).toList(),
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
