import 'package:flutter/material.dart';
//Helps you with screen sizes

Size displaySize(BuildContext context) {
  //Returns the size of the display
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  //Returns height of the display
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  //Returns width of the display
  return displaySize(context).width;
}