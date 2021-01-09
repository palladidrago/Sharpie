import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharpie_app/screens/home.dart';
import 'package:sharpie_app/services/assets.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import '../home.dart';

class MashovCredentials extends StatelessWidget {
  //Is the main "Wrapper" for the first page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sharpie",
      theme: ThemeData(
        fontFamily: "Josefin",
        scaffoldBackgroundColor: Colors.red[300],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mashov Login'),
        ),
        body: SafeArea(
          child: Stack(
            //There's probably a better way to do this than Scaffold<SafeArea<Stack
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.topLeft,
                child: LangBtn(),
              ),
              Align(
                alignment: Alignment(0.9, -0.95),
                child: Image(height: 60, image: AssetImage(Images.logoLoc)),
              ),
              MashovForm(),
            ],
          ),
        ),
      ),
    );
  }
}

// Define a custom Form widget.
class MashovForm extends StatefulWidget {
  @override
  _MashovFormState createState() => _MashovFormState();
}

class _MashovFormState extends State<MashovForm> {
  var mashovController = Controller();

  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  // Globalkey<FormState> is debug only. this might be why building the app doesn't work.
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //Centers the form
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(30.0),
              padding: const EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue[300],
                  width: 3.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Username(Id)",
                      icon: const Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: const Icon(Icons.supervised_user_circle),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Divider(
                    height: 50,
                    thickness: 2,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      icon: const Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: const Icon(Icons.lock),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    obscureText: _obscureText,
                  ),
                  new FlatButton(
                    onPressed: _toggle,
                    child: new Text(_obscureText ? "Show" : "Hide"),
                  ),
                  Divider(
                    height: 50,
                    thickness: 5,
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          //If the form is valid, saves the username and passowrd, and saves the user as logged in.
                          SharedPreferences _prefs =
                              await SharedPreferences.getInstance();
                          final storage = new FlutterSecureStorage();
                          await mashovController.login(nameController.text,
                              passwordController.text, "540484", "2021");
                          await storage.write(
                              key: "mashovUsername",
                              value: nameController.text);
                          await storage.write(
                              key: "mashovPassword",
                              value: passwordController.text);
                          await _prefs.setBool('isLogged', true);
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
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
