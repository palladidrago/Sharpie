import 'package:flutter/material.dart';
import 'package:sharpie_app/services/preferences.dart';
import 'package:sharpie_app/screens/intro/second.dart';
import 'package:sharpie_app/services/assets.dart';

void main() => runApp(FirstPage());

class FirstPage extends StatelessWidget {
  @override
  //Is the main "Wrapper" for the first page
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sharpie",
      theme: ThemeData(
        fontFamily: "Josefin",
        scaffoldBackgroundColor: Colors.red[300],
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            //There's probably a better way to do this then Scaffold<SafeArea<Stack
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
              Align(
                alignment: Alignment(0.9, -0.95),
                child: Image(height: 60, image: AssetImage(Images.logoLoc)),
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
  //Is the button for english and hebrew.
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

class _NameForm extends State<NameForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  //What does the controller do?
  String input =
      ""; //The input will be changed later, we need it like this at the beginning
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    //Useful?
    myController.dispose();
    super.dispose();
  }

  String hiText(String text) {
    //Returns the text to display after the form.
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
          crossAxisAlignment: CrossAxisAlignment.center, //Centers the form
          children: <Widget>[
            TextFormField(
              //Is the form
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
                  //On changed, reset the state of the widget with input = value.
                  input = value;
                });
              },
            ),
            SizedBox(
              //Padding
              height: 8,
            ),
            RaisedButton(
              //Submit button.
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
              //Padding
              height: 20,
            ),
            Text(
              //Text, displays the name of the student while typing.
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
