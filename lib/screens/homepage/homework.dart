import 'package:flutter/material.dart';
import '../../services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Homework extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeworkDB(),
    );
  }
}

class HomeworkDB extends StatefulWidget {
  @override
  _HomeworkDBState createState() => _HomeworkDBState();
}

class _HomeworkDBState extends State<HomeworkDB> {
  static var _homework = FirestoreDB.getDBdata("homework");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homework"),
      ),
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
          future: _homework,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var homework;
              snapshot.data.docs.forEach((homeworkData) {
                homework = homeworkData.data();
              });

              return Column(
                children: [
                  Container(
                    child: Text(
                      "Math: ${homework['math']}\nEnglish: ${homework['english']}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
