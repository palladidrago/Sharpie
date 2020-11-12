import 'package:flutter/material.dart';
import 'package:sharpie_app/services/preferences.dart';
import 'package:sharpie_app/screens/intro/second.dart';

void main() => runApp(FirstPage());

class FirstPage extends StatelessWidget {
  // static String name = "students";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sharpie",
      theme: ThemeData(
        fontFamily: "Josefin",
        scaffoldBackgroundColor: Colors.red[300],
      ),
      // Set Work as the default app font.
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                child: NameForm(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: LangBtn(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LangBtn extends StatefulWidget {
  @override
  _LangBtnState createState() => _LangBtnState();
}

class _LangBtnState extends State<LangBtn> {
  String altLanguage = "עברית";
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(altLanguage),
      backgroundColor: Colors.blue[300],
      foregroundColor: Colors.black,
      onPressed: () {
        setState(() {
          if (altLanguage != "עברית") {
            altLanguage = "עברית";
          } else {
            altLanguage = "English";
          }
        });
      },
    );
  }
}

// Define a custom Form widget.
class NameForm extends StatefulWidget {
  @override
  _NameForm createState() => _NameForm();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _NameForm extends State<NameForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  String input = "";
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  String hiText(String text) {
    if (text == "") {
      return "student";
    } else {
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: myController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: (String value) {
                setState(() {
                  input = value;
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              onPressed: () async {
                if (input != "") {
                  Preferences.setName(input);
                  String name = await Preferences.getName();
                  print(name);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                }
              },
              child: Text('Submit'),
              elevation: 8,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Hi ${hiText(input)}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
