import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uusfm/animation/fadeanimation.dart';
import 'package:uusfm/model/sessionmodel.dart';
import 'package:uusfm/viewmodel/bookingviewmodel.dart';
import 'package:uusfm/viewmodel/membershipviewmodel.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

class BookingForm2 extends StatefulWidget {
  final SessionModel _Sessionmodel;
  UserViewmodel _userViewmodel;
  BookingForm2(userviewmodel, sessionmodel)
      : _userViewmodel = userviewmodel,
        _Sessionmodel = sessionmodel;

  @override
  State<BookingForm2> createState() => _BookingForm2State();
}

class _BookingForm2State extends State<BookingForm2> {
  TextEditingController cName;
  TextEditingController sessionType;
  TextEditingController bookDate;
  TextEditingController bookTime;
  TextEditingController phoneNum;
  TextEditingController bookingReceipt;

  String res;

  String imageData;
  File imageFile;
  String fileName;
  String base64Image;

  @override
  Future<void> initState() {
    super.initState();
    cName = TextEditingController(text: widget._userViewmodel.user.cName);
    sessionType = TextEditingController(text: widget._Sessionmodel.sessionType);
    bookDate = TextEditingController(text: widget._Sessionmodel.sessionDate);
    bookTime = TextEditingController(text: widget._Sessionmodel.sessionTime);
    phoneNum =
        TextEditingController(text: widget._userViewmodel.user.cPhoneNum);
    bookingReceipt =
        TextEditingController(text: widget._Sessionmodel.sessionType);
  }

  var ySnackBar = const SnackBar(
    content: Text('You already booked this session!'),
  );

  Future BookNow() async {
    Bookingviewmodel _bookingviewmodel = Bookingviewmodel();

    if (widget._userViewmodel.user.id.isNotEmpty &
        cName.text.isNotEmpty &
        widget._Sessionmodel.id.isNotEmpty &
        sessionType.text.isNotEmpty &
        bookDate.text.isNotEmpty &
        bookTime.text.isNotEmpty &
        phoneNum.text.isNotEmpty) {
      String res = await _bookingviewmodel.checkBooking(
          widget._userViewmodel.user.id, widget._Sessionmodel.id);
      print(res);
      // print(phoneNum.text.trim());
      if (res == "available") {
        String res = await _bookingviewmodel.StoreBooking(
          widget._userViewmodel.user.id,
          cName.text.trim(),
          sessionType.text.trim(),
          widget._Sessionmodel.id,
          bookDate.text.trim(),
          bookTime.text.trim(),
          phoneNum.text.trim(),
          fileName,
        );
        print(res);
        if (res == "success") {
          String res = await _bookingviewmodel.UploadImage(imageFile);
          cName.clear();
          sessionType.clear();
          bookDate.clear();
          bookTime.clear();
          phoneNum.clear();

          var RegisterSnackBar = const SnackBar(
            content: Text('Successfully booked!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(RegisterSnackBar);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(ySnackBar);
      }
    }
  }

  Future CheckMembership() async {
    Membershipviewmodel _membershipviewmodel = Membershipviewmodel();

    res = await _membershipviewmodel
        .checkMembership(widget._userViewmodel.user.id);
    print(res);
    return (res);
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    imageFile = File(image.path);

    imageData = imageFile.toString();

    fileName = imageFile.path.split('/').last;
    base64Image = base64Encode(imageFile.readAsBytesSync());

    const start = "'";
    const end = "'";

    final startIndex = imageData.indexOf(start);
    final endIndex = imageData.indexOf(end, startIndex + start.length);

    imageData = imageData.substring(startIndex + start.length, endIndex);
    if (imageFile == null) return;
    print(fileName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CheckMembership(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Color(0xff191720),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xFFFAFAFA),
                  centerTitle: true,
                  title: Text(
                    'Book Session',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                body: Container(
                  child: Center(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: cName,
                          decoration: InputDecoration(
                            labelText: 'Full name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: phoneNum,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          enabled: false,
                          controller: sessionType,
                          decoration: InputDecoration(
                            labelText: "Type",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          enabled: false,
                          controller: bookDate,
                          decoration: InputDecoration(
                            labelText: "Date",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          enabled: false,
                          controller: bookTime,
                          decoration: InputDecoration(
                            labelText: "Time",
                          ),
                        ),
                      ),
                      if (widget._Sessionmodel.sessionType == "Gymnasium" &&
                          res == "failed")
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            enabled: false,
                            initialValue: 'RM 5',
                            decoration: InputDecoration(
                              labelText: 'Fee',
                            ),
                          ),
                        ),
                      if (widget._Sessionmodel.sessionType == "Stadium")
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            enabled: false,
                            initialValue: 'RM 150',
                            decoration: InputDecoration(
                              labelText: 'Fee',
                            ),
                          ),
                        ),
                      if (widget._Sessionmodel.sessionType == "FootballField" &&
                          widget._Sessionmodel.sessionTime == '08:00:00' &&
                          res == "failed")
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            enabled: false,
                            initialValue: 'RM 800',
                            decoration: InputDecoration(
                              labelText: 'Fee',
                            ),
                          ),
                        ),
                      if (widget._Sessionmodel.sessionType == "FootballField" &&
                          widget._Sessionmodel.sessionTime == '20:00:00' &&
                          res == "failed")
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            enabled: false,
                            initialValue: 'RM 1600',
                            decoration: InputDecoration(
                              labelText: 'Fee',
                            ),
                          ),
                        ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(56),
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          textStyle: TextStyle(fontSize: 20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.camera, size: 28),
                            const SizedBox(width: 16),
                            Text('Add Receipt'),
                          ],
                        ),
                        onPressed: () {
                          pickImage();
                        },
                      ),
                      ElevatedButton(
                        child: Text("Book Now"),
                        onPressed: BookNow,
                      ),
                      if (widget._userViewmodel.user.cVerifyStatus ==
                          "Unverified")
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/membership');
                          },
                          child: RichText(
                            text: TextSpan(
                                text: "Not a member yet? ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                      text: "Apply here",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor))
                                ]),
                          ),
                        ),
                    ],
                  )),
                ),
              );
            }
          }
        });
  }
}
