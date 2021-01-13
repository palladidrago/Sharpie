import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_mashovapi/simple_mashovapi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/assets.dart';
import 'grades.dart';
import 'schedule.dart';

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
    final storage = new FlutterSecureStorage();
    await mashovController.login(await storage.read(key: "mashovUsername"),
        await storage.read(key: "mashovPassword"), "540484", "2021");
    return await mashovController.getName(); //Returns list of Grades
  }

  @override
  Widget build(BuildContext context) {
    // what we'll actually do instead of [1,2,3,4,5] is make a list<lesson> and feed this sexy animal with data from artyeshiva
    List<int> lessons = [1, 2, 3, 4];
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
                child:  Padding(
                padding: const EdgeInsets.only(
                bottom: 300,
               ),
                child: Schedule(),
            ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 550,
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
