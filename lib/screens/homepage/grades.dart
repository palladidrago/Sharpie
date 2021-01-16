import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GradePage extends StatefulWidget {
  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  var comment;
  var _grades = _getGrades();
  static Future<List<Grade>> _getGrades() async {
    //Returns list of grades.
    var mashovController = Controller();
    final storage = new FlutterSecureStorage();
    await mashovController.login(await storage.read(key: "mashovUsername"),
        await storage.read(key: "mashovPassword"), "540484", "2021");
    return await mashovController.getGradeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grades'),
        // the background color could vary
        // if the average grade of the student is below e.g., 60
        // then the background color would be red and if above e.g., 80 etc...
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Grade>>(
          future: _grades,
          builder: (BuildContext context, AsyncSnapshot<List<Grade>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  var gr = snapshot.data[snapshot.data.length - i - 1];
                  dynamic gradeVal = gr.grade ?? 0;

                  Color gradeColor = (gradeVal >= 85)
                      ? Colors.green
                      : (gradeVal > 55 ? Colors.grey : Colors.red);
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
                          margin: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$gradeVal",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: gradeColor,
                                ),
                              ),
                              Text(
                                "${gr.eventDate}",
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
                          margin: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${gr.subjectName}",
                                textAlign: TextAlign.end,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${gr.gradingEvent}",
                                textAlign: TextAlign.end,
                                textDirection: TextDirection.rtl,
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

// class GradeBox extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//   }
// }
