import 'dart:convert';

import 'package:uusfm/globalvariable.dart';
import 'package:uusfm/model/membershipmodel.dart';
import 'package:uusfm/viewmodel/viewmodel.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class Membershipviewmodel extends Viewmodel {
  Future<String> StoreMembership(
      String cID,
      String membershipType,
      String membershipEntry,
      String membershipExpired,
      String membershipReceipt) async {
    print(membershipReceipt);
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/storeMembership.php?";

    var result = await http.post(Uri.parse(url),
        body: jsonEncode(<String, String>{
          'cID': cID,
          'membershipType': membershipType,
          'membershipEntry': membershipEntry,
          'membershipExpired': membershipExpired,
          'membershipReceipt': membershipReceipt,
        }));

    if (result.body == "failed") return null;

    String response = result.body;
    //final _user = User.fromJson(json);
    return response;
  }

  Future<String> checkMembership(String cID) async {
    //print(cID);
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/checkMembership.php?cID='" +
        cID +
        "'";
    // var url = "http://localhost:8080/MobileAPI/login.php?cEmail=" +
    //     cEmail +
    //     "&&cPassword=" +
    //     cPassword;
    //print(url);
    var result = await http.get(Uri.parse(url));
    //print(result.body);

    String response = result.body;
    print(response);
    //final _user = User.fromJson(json);
    return response;
  }

  Future<String> checkMembershipApplication(String cID) async {
    //print(cID);
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/checkMembershipApplication.php?cID='" +
        cID +
        "'";
    // var url = "http://localhost:8080/MobileAPI/login.php?cEmail=" +
    //     cEmail +
    //     "&&cPassword=" +
    //     cPassword;
    //print(url);
    var result = await http.get(Uri.parse(url));
    //print(result.body);

    String response = result.body;
    print(response);
    //final _user = User.fromJson(json);
    return response;
  }
}

Future<List<MembershipModel>> viewMembership(String cID) async {
  var url = "http://" +
      GlobalVariables.IPAddress +
      "/MobileAPI/viewMembership.php?cID='" +
      cID +
      "'";
  // var url = "http://localhost:8080/MobileAPI/login.php?cEmail=" +
  //     cEmail +
  //     "&&cPassword=" +
  //     cPassword;
  //print(url);
  var result = await http.get(Uri.parse(url));
  //print(result.body);
  if (result.body == "failed") return null;

  // final json = jsonDecode(result.body);
  // final _submission = json.map((e) => Feed.fromJson(e)).toList();
  return membershipModelFromJson(result.body);
}
