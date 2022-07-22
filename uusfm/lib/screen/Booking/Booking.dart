import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uusfm/screen/Booking/Football.dart';
import 'package:uusfm/screen/Booking/Gymnasium.dart';
import 'package:uusfm/screen/Booking/Stadium.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

class Booking extends StatelessWidget {
  UserViewmodel _userViewmodel;
  Booking(userviewmodel) : _userViewmodel = userviewmodel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.menu),
        //   color: Colors.black,
        // ),
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: true,
        title: Text(
          'Booking',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color.fromARGB(255, 221, 226, 240),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Gymnasium(_userViewmodel)),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.fitness_center),
                      SizedBox(width: 20),
                      Expanded(child: Text('Gymnasium')),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color.fromARGB(255, 221, 226, 240),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Stadium(_userViewmodel)),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.stadium),
                      SizedBox(width: 20),
                      Expanded(child: Text('Stadium')),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color.fromARGB(255, 221, 226, 240),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Football(_userViewmodel)),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.sports_soccer),
                      SizedBox(width: 20),
                      Expanded(child: Text('Football Field')),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
