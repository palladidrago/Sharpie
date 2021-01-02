import 'package:flutter/material.dart';
import 'package:sharpie_app/screens/intro/splash.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  runApp(Sharpie());
  var controller = Controller();
  await DotEnv().load('.env');
  await controller.login(
      DotEnv().env['USERNAME'], DotEnv().env['PASSWORD'], "540484", "2021");
  var grades = await controller.getGradeList(); //Returns list of Grades
  for (var grade in grades) {
    print('${grade.subjectName}: ${grade.grade}');
  }
  // for (var grade = 0; grade < grades.length; grade++) {
  //   print('${grades[grade].subjectName}: ${grades[grade].grade}');
  // }
}

class Sharpie extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Splash();
}
