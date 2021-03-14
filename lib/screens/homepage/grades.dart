import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GradePage extends StatefulWidget {
  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  var comment;
  static List<int> gradesList = [];
  var _grades = _getGrades();
  static Future<List<Grade>> _getGrades() async {
    //Returns list of grades.
    var mashovController = Controller();
    final storage = new FlutterSecureStorage();
    if (!Platform.isMacOS) {
      await mashovController.login(await storage.read(key: "mashovUsername"),
          await storage.read(key: "mashovPassword"), "540484", "2021");
    } else {
      await mashovController.login(
          env['USERNAME'], env['PASSWORD'], "540484", "2021");
    }
    return await mashovController.getGradeList();
  }

  static var _avgGrades = _gradesAverage();
  static Future<double> _gradesAverage() async {
    var grades = await _getGrades();
    dynamic gradeVal;

    for (var gr in grades) {
      gradeVal = gr.grade ?? 0;
      gradesList.add(gradeVal);
    }

    double average =
        gradesList.fold(0, (prv, curr) => prv + curr) / gradesList.length;

    return double.parse((average).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<double>(
          future: _avgGrades,
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            if (snapshot.hasData) {
              var avgGrades = snapshot.data;
              return Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: avgGrades >= 80
                      ? Colors.green
                      : (avgGrades >= 55 ? Colors.grey : Colors.red),
                ),
                child: Text(
                  "ממוצה: ${avgGrades.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error");
            } else {
              return Text("Loading...");
            }
          },
        ),
        backgroundColor: Colors.grey[400],
      ),
      body: SafeArea(
        child: FutureBuilder<List<Grade>>(
          future: _grades,
          builder: (BuildContext context, AsyncSnapshot<List<Grade>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var grades = snapshot.data;
                  var _grade = grades[grades.length - index - 1];

                  dynamic gradeVal = _grade.grade ?? 0;

                  Color gradeColor = (gradeVal >= 85)
                      ? Colors.green
                      : (gradeVal > 55 ? Colors.grey : Colors.red);
                  return Container(
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
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "$gradeVal",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: gradeColor,
                                ),
                              ),
                              Text(
                                "${_grade.eventDate}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "${_grade.subjectName}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${_grade.gradingEvent}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
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
        ),
      ),
    );
  }
}
