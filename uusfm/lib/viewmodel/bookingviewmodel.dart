import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uusfm/globalvariable.dart';
import 'package:uusfm/model/bookingmodel.dart';
import 'package:uusfm/viewmodel/viewmodel.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

var IPAddress = "68.183.185.251";

class Bookingviewmodel extends Viewmodel {
  Future<String> StoreBooking(
      BookingModel booking, String bookingReceipt) async {
    var url = "http://" + IPAddress + "/MobileAPI/storeBooking.php?";

    var result = await http.post(Uri.parse(url),
        body: jsonEncode(<String, String>{
          'cID': booking.cId,
          'cName': booking.cName,
          'sessionType': booking.sessionType,
          'sessionID': booking.sessionId,
          'bookDate': booking.bookDate.toString(),
          'bookTime': booking.bookTime,
          'phoneNum': booking.phoneNum,
          'bookingReceipt': bookingReceipt,
        }));
    print(result.body);
    if (result.body == "failed") return null;

    String response = result.body;
    //final _user = User.fromJson(json);
    return response;
  }

  Future<String> UploadImage(File bookingReceipt) async {
    // var url = Uri.parse("http://68.183.185.251/MobileAPI/uploadImages.php");

    // var request = http.MultipartRequest('POST', url);
    // var pic = await http.MultipartFile.fromPath("image", bookingReceipt.path);
    // print(bookingReceipt.path);
    // request.files.add(pic);
    // var response = await request.send();

    var uri = Uri.parse("http://68.183.185.251/MobileAPI/uploadImages.php");
    var request = http.MultipartRequest("POST", uri);
    var pic = await http.MultipartFile.fromPath("image", bookingReceipt.path);
    request.files.add(pic);
    var r = await request.send();
    print(r);

    // if (response.statusCode == 200) {
    //   print('Image Uploaded');
    // } else {
    //   print('Upload Failed');
    // }
  }

  Future<String> checkBooking(String cID, String sessionID) async {
    var url = "http://" +
        GlobalVariables.IPAddress +
        "/MobileAPI/checkBooking.php?cID='" +
        cID +
        "'&&sessionID='" +
        sessionID +
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
}

Future<List<BookingModel>> viewBooking(String cID) async {
  var url = "http://" +
      GlobalVariables.IPAddress +
      "/MobileAPI/viewBooking.php?cID='" +
      cID +
      "'";

  //print(url);
  var result = await http.get(Uri.parse(url));
  //print(result.body);
  if (result.body == "failed") return null;

  // final json = jsonDecode(result.body);
  // final _submission = json.map((e) => Feed.fromJson(e)).toList();
  return bookingModelFromJson(result.body);
}
