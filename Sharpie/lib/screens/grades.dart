import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
              var gr = snapshot.data[i];
              Icon reactionIcon = (gr.grade > 85)
                  ? Icon(Icons.sentiment_satisfied_alt, color: Colors.green)
                  : (gr.grade > 70
                      ? Icon(Icons.sentiment_neutral_outlined,
                          color: Colors.grey)
                      : Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        ));
              return Container(
                  //"${gr.grade}---${gr.gradingEvent}, מקצוע: ${gr.subjectName}",
                  height: 75,
                  margin: EdgeInsets.only(top:15),
                   decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                  ),
                  width: MediaQuery.of(context).size.width - 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      reactionIcon,
                      SizedBox(width: 10),
                      Text(
                        "${gr.grade}  ${gr.subjectName},${gr.gradingEvent}",
                        textDirection: TextDirection.rtl,
                        style:TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )


                        )
                    ],
                  ));
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
