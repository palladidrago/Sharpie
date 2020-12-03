import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:requests/requests.dart';



class TestHelper{
  static String artRssLink = 'https://art-yeshiva.org.il/WS/RssEvents.aspx';
  static dynamic getTestFromKita(int kita) async{
    //Returns the latest test for given kita 
    //kita- number from 7 - 12(ז-ח) +0+ First class or second (example: ז1=701 ,יא1=1101)

    var artRssRawR = await Requests.get("$artRssLink?kita=${kita.toString()}");
    String artRssRaw = artRssRawR.content();
    var artRss = RssFeed.parse(artRssRaw).items.first;
    //Todo: this only works if there is one hakbatza for the test, but if there is more than 1
    //you need to find a way to take the right item based on it. 
    return artRss;// An RssFeed object.
  }
}
class MashovHelper{
  void saveLogin(String username,String password, String semel, String year){
    
  }

}
class DisplaySize{
  //Helps you with screen sizes
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
