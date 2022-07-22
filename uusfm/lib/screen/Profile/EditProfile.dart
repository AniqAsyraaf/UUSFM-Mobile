import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uusfm/model/sessionmodel.dart';
import 'package:uusfm/model/user.dart';
import 'package:uusfm/viewmodel/bookingviewmodel.dart';
import 'package:uusfm/viewmodel/profileviewmodel.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

class EditProfile extends StatefulWidget {
  UserViewmodel _userViewmodel;
  EditProfile(userviewmodel) : _userViewmodel = userviewmodel;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController cName;
  TextEditingController cPassword;
  TextEditingController cEmail;
  TextEditingController cPhoneNum;
  TextEditingController cVerifyStatus;

  /// Name is Empty
  var aSnackBar = const SnackBar(
    content: Text('The Name field must fill!'),
  );

  /// Phone Number is Empty
  var bSnackBar = const SnackBar(
    content: Text('The Phone Number field must fill!'),
  );

  /// Password is Empty
  var cSnackBar = const SnackBar(
    content: Text('The Password field must fill!'),
  );

  /// Name & Phone Number is Empty
  var dSnackBar = const SnackBar(
    content: Text('The Name & Phone Number fields must fill!'),
  );

  /// Name & Password is Empty
  var eSnackBar = const SnackBar(
    content: Text('The Name & Password fields must fill!'),
  );

  /// Phone Number & Password is Empty
  var fSnackBar = const SnackBar(
    content: Text('The Phone Number & Password fields must fill!'),
  );

  /// All Fields Empty
  var xSnackBar = const SnackBar(
    content: Text('You must fill all fields'),
  );

  @override
  void initState() {
    super.initState();

    //getCustData();
    cName = TextEditingController(text: widget._userViewmodel.user.cName);
    cPassword =
        TextEditingController(text: widget._userViewmodel.user.cPassword);
    cEmail = TextEditingController(text: widget._userViewmodel.user.cEmail);
    cPhoneNum =
        TextEditingController(text: widget._userViewmodel.user.cPhoneNum);
    cVerifyStatus =
        TextEditingController(text: widget._userViewmodel.user.cVerifyStatus);
  }

  Future getCustData() async {
    print('getcustdata');
    Profileviewmodel _profileviewmodel = Profileviewmodel();

    Future<User> _user =
        _profileviewmodel.getCustData(widget._userViewmodel.user.id);

    if (_user != null) {
      UserViewmodel _userviewmodel = UserViewmodel();
      _userviewmodel.user = _user;
      print(widget._userViewmodel.user.cName);
    }
  }

  Future updateProfile() async {
    Profileviewmodel _profileviewmodel = Profileviewmodel();

    if (widget._userViewmodel.user.id.isNotEmpty &
        cName.text.isNotEmpty &
        cPassword.text.isNotEmpty &
        cEmail.text.isNotEmpty &
        cPhoneNum.text.isNotEmpty) {
      // String res = await _bookingviewmodel.checkBooking(
      //     widget._userViewmodel.user.id, widget._Sessionmodel.id);
      // print(res);
      // if (res == "available") {
      String res = await _profileviewmodel.updateProfile(
        widget._userViewmodel.user.id,
        cName.text.trim(),
        cPassword.text.trim(),
        cPhoneNum.text.trim(),
      );
      print(res);
      if (res == "success") {
        //await getCustData;
        print('asda');
        var RegisterSnackBar = const SnackBar(
          content: Text('Successfully updated!'),
        );
        ScaffoldMessenger.of(context).showSnackBar(RegisterSnackBar);

        setState(() {});
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => EditProfile(widget._userViewmodel)),
        // );
      }
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(ySnackBar);
      // }
    } else if (cName.text.isEmpty &
        cPassword.text.isNotEmpty &
        cPhoneNum.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(aSnackBar);
    }

    ///
    else if (cName.text.isNotEmpty &
        cPassword.text.isNotEmpty &
        cPhoneNum.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(bSnackBar);
    }

    ///
    else if (cName.text.isNotEmpty &
        cPassword.text.isEmpty &
        cPhoneNum.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(cSnackBar);
    }

    ///
    else if (cName.text.isEmpty &
        cPassword.text.isNotEmpty &
        cPhoneNum.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(dSnackBar);
    }

    ///
    else if (cName.text.isEmpty &
        cPassword.text.isEmpty &
        cPhoneNum.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(eSnackBar);
    }

    ///
    else if (cName.text.isNotEmpty &
        cPassword.text.isEmpty &
        cPhoneNum.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(fSnackBar);
    }

    ///
    else {
      ScaffoldMessenger.of(context).showSnackBar(xSnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: true,
        title: Text(
          'Edit Profile',
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
                enabled: false,
                controller: cEmail,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                obscureText: true,
                controller: cPassword,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: cPhoneNum,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                enabled: false,
                controller: cVerifyStatus,
                decoration: InputDecoration(
                  labelText: "Verification Status",
                ),
              ),
            ),
            ElevatedButton(
              child: Text("Update"),
              onPressed: updateProfile,
            ),
          ],
        )),
      ),
    );
  }
}
