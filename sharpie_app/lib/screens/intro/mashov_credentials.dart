import 'package:flutter/material.dart';
import 'package:sharpie_app/screens/home.dart';
import 'package:sharpie_app/services/preferences.dart';
import 'package:sharpie_app/services/assets.dart';

class MashovCredentials extends StatelessWidget {
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
            //There's probably a better way to do this than Scaffold<SafeArea<Stack
            children: <Widget>[
              MashovForm(),
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

// Define a custom Form widget.
class MashovForm extends StatefulWidget {
  @override
  _MashovFormState createState() => _MashovFormState();
}

class _MashovFormState extends State<MashovForm> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    //Useful?
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
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
                    labelText: "Email",
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                ),
                Container(
                  child: ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data...')));
                        Preferences.setStringValue("name", nameController.text);
                        Preferences.setStringValue(
                            "password", passwordController.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
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
