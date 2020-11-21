import 'package:flutter/material.dart';
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


}