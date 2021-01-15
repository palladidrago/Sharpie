import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
              Color gradeColor = (gr.grade >= 85)
                  ? Colors.green
                  : (gr.grade > 55 ? Colors.grey : Colors.red);
              return Container(
                  //"${gr.grade}---${gr.gradingEvent}, מקצוע: ${gr.subjectName}",
                  height: 75,
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: MediaQuery.of(context).size.width - 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // i added containers so we can add some edge insets
                        margin: EdgeInsets.all(15),
                        child:Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                        Text("${gr.grade}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: gradeColor,
                            )),
                        Text("${gr.eventDate}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            )),
                      ])),
                      Container(
                        margin: EdgeInsets.all(12),
                        child:Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${gr.subjectName}",
                              textAlign: TextAlign.end,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("${gr.gradingEvent}",
                              textAlign: TextAlign.end,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              )
               
                          )

                          // grade desc and grade subject
                        ],
                      ))
                    ],
                  ));
            },
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        } else {
          return Center(
            child: SpinKitDoubleBounce(color: Colors.blue.withOpacity(0.3)),
          );
        }
      },
    );
  }
}
