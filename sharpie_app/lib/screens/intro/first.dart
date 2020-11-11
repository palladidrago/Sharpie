import 'package:flutter/material.dart';
import 'package:sharpie_app/services/preferences.dart';

void main() => runApp(FirstPage());

class FirstPage extends StatelessWidget {
  // static String name = "students";
  final MyCustomForm form = MyCustomForm();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sharpie",
      // Set Work as the default app font.
      home: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                child: form,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  String input = "student";
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
      appBar: AppBar(
        title: Text(
          'Sharpie',
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.red[40],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: myController,
              decoration: InputDecoration(labelText: "What's your name?"),
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
                Preferences.setName(input);
                String name = await Preferences.getName();
                print(name);
              },
              child: Text('Submit'),
              elevation: 8,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Hi $input",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
