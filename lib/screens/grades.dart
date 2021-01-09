import 'package:flutter/material.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GradeList extends StatefulWidget {
  @override
  _GradeListState createState() => _GradeListState();
}

class _GradeListState extends State<GradeList> {
  var _grades= _getGrades(); //Saves list of grades in variable
  static Future<List<Grade>> _getGrades() async{
    //Returns list of grades.
    var controller = Controller();
    await DotEnv().load('.env');
    await controller.login(
      DotEnv().env['USERNAME'], DotEnv().env['PASSWORD'], "540484", "2021");
    return await controller.getGradeList(); //Returns list of Grades
  }

  
  @override
  Widget build(BuildContext context) {
    //Build an ugly list of grades.
      return FutureBuilder<List<Grade>>(
      future: _grades,
      builder: (BuildContext context, AsyncSnapshot<List<Grade>> snapshot){
        if (snapshot.hasData){
          
          return MaterialApp(
            home: ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snapshot.data.length,
            itemBuilder:  (context, i) { 
            var gr = snapshot.data[i];
            return  Text(
                "${gr.grade}---${gr.gradingEvent}",
                style: TextStyle(color:Colors.white, fontSize:12),
                );
              }
            )
          );
        }else if (snapshot.hasError) {
            return Text("Error");
        }else{
          return Text('Awaiting result...');
        }
      }
    );
  }
}