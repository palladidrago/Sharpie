import 'package:flutter/material.dart';
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
