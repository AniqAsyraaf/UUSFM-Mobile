import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uusfm/animation/fadeanimation.dart';
import 'package:uusfm/model/usermodel.dart';
import 'package:uusfm/screen/Homepage/homepage.dart';
import 'package:uusfm/model/feedmodel.dart';
import 'package:uusfm/screen/Main/mainscreen.dart';
import 'package:uusfm/viewmodel/loginviewmodel.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user.dart';

class Login extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => Login());
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: cEmail,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                controller: cPassword,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
            ),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () async {
                Loginviewmodel _loginviewmodel = Loginviewmodel();
                //Feedviewmodel _feedviewmodel = Feedviewmodel();
                // test data
                // print(cEmail.text);
                // print(cPassword.text);

                User _user =
                    await _loginviewmodel.login(cEmail.text, cPassword.text);

                if (_user != null) {
                  UserViewmodel _userviewmodel = UserViewmodel();
                  _userviewmodel.user = _user;

                  // final SharedPreferences sharedPreferences =
                  //     await SharedPreferences.getInstance();
                  // sharedPreferences.setString('email', cEmail.text);

                  //print(_user.cEmail);
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString('user', jsonEncode(_user));

                  // Navigator.pushNamed(context, '/mainscreen',
                  //     arguments: _userviewmodel);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Mainscreen(_userviewmodel)),
                  );
                } else {
                  var fSnackBar = const SnackBar(
                    content: Text('Incorrect email or password!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(fSnackBar);
                }
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: FadeAnimation(
                delay: 1,
                child: RichText(
                  text: TextSpan(
                      text: "Don't have an account?",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                            text: "Register",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor))
                      ]),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
