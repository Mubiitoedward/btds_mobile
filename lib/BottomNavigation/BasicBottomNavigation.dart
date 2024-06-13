import 'package:btds_mobile/Darshboard/Diagonise.dart';
import 'package:btds_mobile/data/my_colors.dart';
import 'package:btds_mobile/screens/Results.dart';
import 'package:btds_mobile/screens/stories.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int index;
  BottomBar({required this.index});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  List<Widget> bottomscreens = [
    Diagonise(),
    ResultsPage(),
    Stories()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: bottomscreens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: MyColors.accent,
          onTap: (value) {
            setState(() {
              _currentIndex = value; // Update the selected index
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: "Diagonise"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded), label: "Results"),
                 BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_rounded), label: "RegisterPatient"),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
