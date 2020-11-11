import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  String name = "student";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sharpie",
      home: Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                child: Center(
                  child: Text(
                    "Hi $name",
                    style: TextStyle(/*style this shit*/),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Hi $name",
                  textAlign: TextAlign.left,
                  style: TextStyle(/*style this shit*/),
                ),
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
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (text) {
                print("First text field: $text");
              },
              controller: myController,
            ),
          ],
        ),
      ),
    );
  }
}
