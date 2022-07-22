import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uusfm/model/user.dart';
import 'package:uusfm/screen/Main/mainscreen.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

import 'app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // var obtainedEmail = sharedPreferences.getString('user');

  UserViewmodel _userviewmodel = UserViewmodel();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var username = preferences.getString('user');
  if (username != null) {
    Map json = await jsonDecode(username);
    var user = User.fromJson(json);
    _userviewmodel.user = user;
    //print(_userviewmodel.user.cName);
  }

  //print(_userviewmodel.user.cName);
  if (username != null) {
    runApp(
      MaterialApp(
        title: 'MVVM Template',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        //initialRoute: '/mainscreen',
        home: Mainscreen(_userviewmodel),
        onGenerateRoute: createRoute,
      ),
    );
  } else {
    runApp(
      MaterialApp(
        title: 'MVVM Template',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        onGenerateRoute: createRoute,
      ),
    );
  }
}
