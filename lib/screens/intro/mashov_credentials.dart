import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import '../../services/assets.dart';
import '../homepage/home.dart';

class MashovCredentials extends StatelessWidget {
  //Is the main "Wrapper" for the first page
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sharpie",
      theme: ThemeData(
        fontFamily: "Josefin",
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Mashov Login'),
              Image(
                height: 45,
                image: AssetImage(Images.logoLoc),
              ),
            ],
          ),
          backgroundColor: Color(0xFFECF677),
        ),
        body: SafeArea(
          child: MashovForm(),
        ),
        backgroundColor: Colors.red[300],
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
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue[300],
                width: 3.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Username(Id)",
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: const Icon(
                        Icons.person,
                        size: 22,
                      ),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your Id';
                    }
                    return null;
                  },
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: const Icon(
                        Icons.lock,
                        size: 22,
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: _toggle,
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: _obscureText,
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
                Container(
                  child: ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        final storage = new FlutterSecureStorage();
                        try {
                          await mashovController.login(nameController.text,
                              passwordController.text, "540484", "2021");
                          if (!Platform.isMacOS) {
                            await storage.write(
                                key: "mashovUsername",
                                value: nameController.text);
                            await storage.write(
                                key: "mashovPassword",
                                value: passwordController.text);
                          }
                          await _prefs.setBool('isLogged', true);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                              title: Text("Error"),
                              content: Text(
                                  "The id or password is wrong. Please try again"),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    nameController.text = '';
                                    passwordController.text = '';
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                  },
                                )
                              ],
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*class LangBtn extends StatefulWidget {
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
}*/
