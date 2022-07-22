import 'dart:convert';

import 'package:uusfm/globalvariable.dart';
import 'package:uusfm/model/usermodel.dart';
import 'package:uusfm/viewmodel/viewmodel.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class Profileviewmodel extends Viewmodel {
  Future<String> updateProfile(
      String id, String cName, String cPassword, String cPhoneNum) async {
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/updateProfile.php?id='" +
        id +
        "'";

    var result = await http.put(Uri.parse(url),
        body: jsonEncode(<String, String>{
          'cName': cName,
          'cPassword': cPassword,
          'cPhoneNum': cPhoneNum,
        }));

    if (result.body == "failed") return null;

    String response = result.body;
    //final _user = User.fromJson(json);
    return response;
  }

  Future<User> getCustData(String id) async {
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/getCustData.php?id='" +
        id +
        "'";

    var result = await http.get(Uri.parse(url));
    print(result.body);

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
}
