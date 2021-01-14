import 'package:flutter/material.dart';
import 'gradesPage.dart';
import 'home.dart';
import 'settings.dart';

class NavBar extends StatefulWidget {
  final index;
  NavBar({@required this.index});
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    var _index = widget.index;
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Color(0xFFF9F9FB),
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      currentIndex: _index,
      onTap: (int tappedIndex) {
        // need to make this work more efficiently 
        if (tappedIndex == 1 && _index != 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GradesPage()));
        } else if (tappedIndex == 0 && _index != 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (tappedIndex == 2 && _index != 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SettingsPage()));
        }
        setState(() {
          _index = tappedIndex;
        });
      },
      type: BottomNavigationBarType.fixed,
      items: [
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
    );
  }
}
