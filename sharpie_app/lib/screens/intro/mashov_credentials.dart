import 'package:flutter/material.dart';
import 'package:sharpie_app/screens/home.dart';
import 'package:sharpie_app/services/preferences.dart';
import 'package:sharpie_app/services/assets.dart';

class MashovCredentials extends StatelessWidget {
  @override
  //Is the main "Wrapper" for the first page
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;

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
              Container(
                margin: EdgeInsets.all(screenHeight * .1),
                child: MashovForm(),
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

// Define a custom Form widget.
class MashovForm extends StatefulWidget {
  @override
  _MashovFormState createState() => _MashovFormState();
}

class _MashovFormState extends State<MashovForm> {
  String email = "";

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    dynamic screenHeight = MediaQuery.of(context).size.height;
    dynamic screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Centers the form
        crossAxisAlignment: CrossAxisAlignment.center, //Centers the form
        children: <Widget>[
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
              children: [
                FormInp(
                  input: email,
                  typeInp: "Email",
                ),
                FormInp(typeInp: "Password"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data...')));
                        if (email != "") {
                          Preferences.setName(email.split("@")[0]);
                          String name = await Preferences.getName();
                          print(name);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            //Text, displays the name of the student while typing.
            "Hi $email",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}

class FormInp extends StatefulWidget {
  final String input;
  final String typeInp;
  const FormInp({Key key, this.input, this.typeInp}) : super(key: key);

  @override
  _FormInpState createState() => _FormInpState(input: this.input);
}

class _FormInpState extends State<FormInp> {
  String greetings(String text) {
    //Returns the text to display after the form.
    if (text == "") {
      return "student";
    } else {
      return text;
    }
  }

  String input = "";
  _FormInpState({this.input});
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    //Useful?
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.typeInp == "Email") {
      return TextFormField(
        controller: myController,
        decoration: InputDecoration(
          labelText: widget.typeInp,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (String value) {
          setState(() {
            //On changed, reset the state of the widget with input = value.
            input = value;
          });
        },
      );
    } else {
      return TextFormField(
        controller: myController,
        decoration: InputDecoration(
          labelText: widget.typeInp,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );
    }
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
