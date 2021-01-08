import 'package:flutter/material.dart';
import 'package:sharpie_app/screens/intro/splash.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async {
  runApp(MyApp());
  var controller = Controller();
  await DotEnv().load('.env');
  List<Grade> grades = await controller.getGradeList(); //Returns list of Grades
  print(grades[grades.length-1].id.toString() + ' grade:' +grades[grades.length-1].grade.toString());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)  => Splash();
}
