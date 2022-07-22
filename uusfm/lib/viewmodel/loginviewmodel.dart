import 'dart:convert';

import 'package:uusfm/globalvariable.dart';
import 'package:uusfm/model/usermodel.dart';
import 'package:uusfm/viewmodel/viewmodel.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class Loginviewmodel extends Viewmodel {
  Future<User> login(String cEmail, String cPassword) async {
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/login.php?cEmail='" +
        cEmail +
        "'&&cPassword='" +
        cPassword +
        "'";

    //print(url);
    var result = await http.get(Uri.parse(url));
    //print(result.body);

    if (result.body == "failed") {
      return null;
    } else if (result.body == "false") {
      return null;
    } else {
      final json = jsonDecode(result.body);
      final _user = User.fromJson(json);
      //print(_user.cName);
      return _user;
    }
  }

  Future<List<UserModel>> checkCurrentUser(String cEmail) async {
    //var url = "http://192.168.190.46:8080/MobileAPI/viewfeed.php";
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/checkCurrentUser.php?cEmail='" +
        cEmail +
        "'";

    //print(url);
    var result = await http.get(Uri.parse(url));
    //print(result.body);
    if (result.body == "failed") return null;

    // final json = jsonDecode(result.body);
    // final _submission = json.map((e) => Feed.fromJson(e)).toList();
    return userModelFromJson(result.body);
  }
}
