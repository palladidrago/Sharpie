import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/assets.dart';
import 'grades.dart';

//Actual home page.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// class lesson for future use
class Lesson {
  String desc;
  String time;
}

class _HomePageState extends State<HomePage> {
  var _name = _getName(); //Saves list of grades in variable
  static Future<Name> _getName() async {
    //Returns list of grades.
    var mashovController = Controller();
    // final storage = new FlutterSecureStorage();
    // await mashovController.login(await storage.read(key: "mashovUsername"),
    //     await storage.read(key: "mashovPassword"), "540484", "2021");
    return await mashovController.getName(); //Returns list of Grades
  }

  @override
  Widget build(BuildContext context) {
    // what we'll actually do instead of [1,2,3,4,5] is make a list<lesson> and feed this sexy animal with data from artyeshiva
    List<int> lessons = [1, 2, 3, 4, 5];
    int _selectedIndex = 0; // for navbar
    return MaterialApp(
      title: "Home",
      theme: ThemeData(
        fontFamily: "Josefin",
        scaffoldBackgroundColor: Colors.red[300],
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFD4E7FE),
                    Color(0xFFF9F9FB),
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(Images.logoLoc),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          FutureBuilder<Name>(
                            future: _name,
                            builder: (BuildContext context,
                                AsyncSnapshot<Name> snapshot) {
                              if (snapshot.hasData) {
                                var name = snapshot.data;
                                return Text(
                                  "שלום!\n${name.firstName} ${name.lastName}",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.blue[900],
                                    //Color(0XFF343E87
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text("Error");
                              } else {
                                return Text('Awaiting result...');
                              }
                            },
                          ),
                          // Text(
                          //   "!שלום מאיר",
                          //   style: TextStyle(
                          //     fontSize: 30,
                          //     fontWeight: FontWeight.w900,
                          //     color: Colors.blue[900],
                          //     //Color(0XFF343E87
                          //   ),
                          // ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "👇 מערכת להיום מוצגת למטה",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF343E87),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 160,
              child: Container(
                height: MediaQuery.of(context).size.height - 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: List.generate(
                    lessons.length,
                    (index) {
                      return Container(
                        // the time will be lessons[index].time, the class description will be lessons[index].desc
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(left: 30),
                        height: 75,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFF9F9FB),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "8:45",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "AM",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              // the line seperating time of lesson and description
                              height: 75,
                              width: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "מתמטיקה(5)",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blueGrey),
                                ),
                                Text(
                                  "הרב אירנה {יא1,יא2}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 650,
                right: 50,
              ),
              child: GradeList(),
            ),
            // GradeList(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Color(0xFFF9F9FB),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            print("hello");
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            // i added "title : Text() cause apparently all items in navigation bar must have a non-null value for title"
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.assessment_outlined),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Sharpie",
//       theme: ThemeData(
//         fontFamily: "Josefin",
//         scaffoldBackgroundColor: Colors.red[300],
//       ),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Grades'),
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: <Widget>[
//               GradeList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
