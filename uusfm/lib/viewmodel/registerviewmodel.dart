import 'dart:convert';

import 'package:uusfm/globalvariable.dart';
import 'package:uusfm/viewmodel/viewmodel.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class Registerviewmodel extends Viewmodel {
  Future<String> register(String cEmail, String cPassword, String cUsername,
      String cPhoneNum) async {
    var url =
        "http://" + GlobalVariables.IPAddress + "/MobileAPI/register.php?";

    var result = await http.post(Uri.parse(url),
        body: jsonEncode(<String, String>{
          'cEmail': cEmail,
          'cPassword': cPassword,
          'cUsername': cUsername,
          'cPhoneNum': cPhoneNum,
        }));
    print(result.body);

    if (result.body == "failed") return null;

    String response = result.body;
    return response;
  }

  Future<String> checkEmail(String cEmail) async {
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/checkEmail.php?cEmail='" +
        cEmail +
        "'";
    // var url = "http://localhost:8080/MobileAPI/login.php?cEmail=" +
    //     cEmail +
    //     "&&cPassword=" +
    //     cPassword;
    //print(url);
    var result = await http.get(Uri.parse(url));
    //print(result.body);
    if (result.body == "failed") return null;

    String response = result.body;
    //final _user = User.fromJson(json);
    return response;
  }

  Future<String> verifyUser(String id) async {
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/verifyUser.php?id='" +
        id +
        "'";
    print(url);
    // cEmail +
    // "'&&cPassword='" +
    // cPassword +
    // "'&&cUsername='" +
    // cUsername +
    // "'&&cPhoneNum='" +
    // cPhoneNum +
    // "'";
    // var url = "http://localhost:8080/MobileAPI/login.php?cEmail=" +
    //     cEmail +
    //     "&&cPassword=" +
    //     cPassword;

    var result = await http.get(Uri.parse(url));
    // var result =
    //     await http.post(Uri.parse(url), body: jsonEncode(<String, String>{}));
    print(result.body);

    if (result.body == "failed") return null;

    String response = result.body;
    //final _user = User.fromJson(json);
    return response;
  }
}
