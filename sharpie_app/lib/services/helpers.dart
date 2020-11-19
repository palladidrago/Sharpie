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

  static Future<dynamic> Test() async{
    var controller = MashovApi.getController();
    var schoolsResult = await controller.getSchools();
    return schoolsResult.value[10];
  }
}