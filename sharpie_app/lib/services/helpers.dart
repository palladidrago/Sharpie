import 'package:flutter/material.dart';
import 'package:mashov_api/mashov_api.dart';
//Helps you with screen sizes

class DisplaySize{
  static Size displaySize(BuildContext context) {
    //Returns the size of the display
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    //Returns height of the display
    return displaySize(context).height;
  }

  static double displayWidth(BuildContext context) {
    //Returns width of the display
    return displaySize(context).width;
  }
}

class MashovHelper{

  Future<void> Test() async{
    var controller =  MashovApi.getController();
    var schools = await controller.getSchools();
    Login data = await
    controller.login(schools.value[1284], "337945240", r"3h6Wc$t%OQPov1Ue@IG", 2020)
    .then((result) => result.value);
    dynamic grades = await controller.getGrades(data.data.userId);
    print(grades);
}
}