import 'package:flutter/material.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GradeList extends StatefulWidget {
  @override
  _GradeListState createState() => _GradeListState();
}

class _GradeListState extends State<GradeList> {
  var comment;
  var _grades = _getGrades(); //Saves list of grades in variable
  static Future<List<Grade>> _getGrades() async {
    //Returns list of grades.
    var mashovController = Controller();
    final storage = new FlutterSecureStorage();
    await mashovController.login(await storage.read(key: "mashovUsername"),
        await storage.read(key: "mashovPassword"), "540484", "2021");
    return await mashovController.getGradeList(); //Returns list of Grades
  }

  @override
  Widget build(BuildContext context) {
    //Build an ugly list of grades.
    return FutureBuilder<List<Grade>>(
      future: _grades,
      builder: (BuildContext context, AsyncSnapshot<List<Grade>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              var gr = snapshot.data[snapshot.data.length-i-1];
              if (gr.grade != null) {
                if (gr.grade > 90) {
                  comment = "WoW";
                } else if (gr.grade > 75) {
                  comment = "nice";
                } else if (gr.grade > 60) {
                  comment = "can do better bro";
                } else {
                  comment = "u threw";
                }
              }
              return Text(
                "${gr.grade}---${gr.gradingEvent}, מקצוע: ${gr.subjectName}\ncomment: $comment\n",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.5,
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        } else {
          return Text('Awaiting result...');
        }
      },
    );
  }
}
