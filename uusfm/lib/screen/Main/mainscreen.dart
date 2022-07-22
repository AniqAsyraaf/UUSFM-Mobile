import 'package:flutter/material.dart';
import 'package:uusfm/model/user.dart';
import 'package:uusfm/screen/Booking/Booking.dart';
import 'package:uusfm/screen/Feed/Feed.dart';
import 'package:uusfm/screen/Profile/Profile.dart';
import 'package:uusfm/model/feedmodel.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

import '../Homepage/homepage.dart';

class Mainscreen extends StatefulWidget {
  final UserViewmodel _userviewmodel;
  const Mainscreen(UserViewmodel userviewmodel)
      : _userviewmodel = userviewmodel;

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    List tabs = [
      Homepage(widget._userviewmodel),
      Booking(widget._userviewmodel),
      Feed(),
      Profile(widget._userviewmodel),
    ];
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online),
              label: 'Booking',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'Feed',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.blue),
        ],
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
