import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uusfm/animation/fadeanimation.dart';
import 'package:uusfm/model/sessionmodel.dart';
import 'package:uusfm/viewmodel/bookingviewmodel.dart';
import 'package:uusfm/viewmodel/membershipviewmodel.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

enum items { Monthly, Entries }

class MembershipForm extends StatefulWidget {
  UserViewmodel _userViewmodel;
  MembershipForm(userviewmodel) : _userViewmodel = userviewmodel;

  @override
  State<MembershipForm> createState() => _MembershipFormState();
}

class _MembershipFormState extends State<MembershipForm> {
  TextEditingController membershipType;
  TextEditingController membershipEntry;
  TextEditingController membershipExpired;
  TextEditingController bookingReceipt;

  String res;

  items _site = items.Monthly;

  String imageData;
  File imageFile;
  String fileName;
  String base64Image;

  @override
  Future<void> initState() {
    super.initState();
  }

  var ySnackBar = const SnackBar(
    content: Text(
        'You already apply for membership. Please wait for admin approval.'),
  );

  Future ApplyNow() async {
    Membershipviewmodel _membershipviewmodel = Membershipviewmodel();
    Bookingviewmodel _bookingviewmodel = Bookingviewmodel();

    if (widget._userViewmodel.user.id.isNotEmpty &
        membershipType.text.isNotEmpty &
        membershipEntry.text.isNotEmpty &
        membershipExpired.text.isNotEmpty) {
      String res = await _membershipviewmodel
          .checkMembershipApplication(widget._userViewmodel.user.id);
      print(res);
      // print(phoneNum.text.trim());
      if (res == "failed") {
        String res = await _membershipviewmodel.StoreMembership(
            widget._userViewmodel.user.id,
            membershipType.text.trim(),
            membershipEntry.text.trim(),
            membershipExpired.text.trim(),
            fileName);
        print(res);
        if (res == "success") {
          String res = await _bookingviewmodel.UploadImage(imageFile);
          var RegisterSnackBar = const SnackBar(
            content: Text('Successfully applied!'),
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

  Future setController(_site) async {
    var now = new DateTime.now();
    var newDate = new DateTime(now.year, now.month + 1, now.day);
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(newDate);

    membershipEntry = TextEditingController(text: '12');
    membershipExpired = TextEditingController(text: formattedDate);

    if (_site.toString() == "items.Entries")
      membershipType = TextEditingController(text: 'Entries');
    if (_site.toString() == "items.Monthly")
      membershipType = TextEditingController(text: 'Monthly');
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
                    'Apply Membership',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                body: Container(
                  child: Center(
                      child: Column(
                    children: [
                      ListTile(
                        title: const Text('Monthly'),
                        leading: Radio(
                          value: items.Monthly,
                          groupValue: _site,
                          onChanged: (items value) {
                            setState(() {
                              _site = value;
                              setController(_site);
                              print('test');
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Entries'),
                        leading: Radio(
                          value: items.Entries,
                          groupValue: _site,
                          onChanged: (items value) {
                            setState(() {
                              _site = value;
                              setController(_site);
                            });
                          },
                        ),
                      ),
                      if (_site.toString() == "items.Monthly")
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            enabled: false,
                            controller: membershipExpired,
                            decoration: InputDecoration(
                              labelText: "Expiration Date",
                            ),
                          ),
                        ),
                      if (_site.toString() == "items.Entries")
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            enabled: false,
                            controller: membershipEntry,
                            decoration: InputDecoration(
                              labelText: "Entries",
                            ),
                          ),
                        ),
                      if (_site.toString() == "items.Monthly" &&
                          widget._userViewmodel.user.cVerifyStatus ==
                              "Unverified")
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            enabled: false,
                            initialValue: 'RM 60',
                            decoration: InputDecoration(
                              labelText: "Fee",
                            ),
                          ),
                        ),
                      if (_site.toString() == "items.Monthly" &&
                          widget._userViewmodel.user.cVerifyStatus ==
                              "Verified")
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            enabled: false,
                            initialValue: 'RM 50',
                            decoration: InputDecoration(
                              labelText: "Fee",
                            ),
                          ),
                        ),
                      if (_site.toString() == "items.Entries")
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            enabled: false,
                            initialValue: 'RM 45',
                            decoration: InputDecoration(
                              labelText: "Fee",
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: '1234567890',
                          decoration: InputDecoration(
                            labelText: "Account Number",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          enabled: false,
                          initialValue: 'CIMB',
                          decoration: InputDecoration(
                            labelText: "Account Bank",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          enabled: false,
                          initialValue: 'UUSFM',
                          decoration: InputDecoration(
                            labelText: "Account Name",
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
                        child: Text("Apply"),
                        onPressed: ApplyNow,
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
