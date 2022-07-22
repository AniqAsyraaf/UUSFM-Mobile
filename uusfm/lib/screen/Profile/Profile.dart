import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uusfm/database/database.dart';
import 'package:uusfm/screen/Membership/membership.dart';
import 'package:uusfm/screen/Profile/EditProfile.dart';
import 'package:uusfm/service/facenet.service.copy.dart';
import 'package:uusfm/service/facenet.service.dart';
import 'package:uusfm/service/ml_kit_service.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

class Profile extends StatefulWidget {
  UserViewmodel _userViewmodel;
  Profile(userviewmodel) : _userViewmodel = userviewmodel;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CameraDescription cameraDescription;
  FaceNetService _faceNetService = FaceNetService();
  FaceNetServiceCopy _faceNetServiceCopy = FaceNetServiceCopy();
  MLKitService _mlKitService = MLKitService();
  DataBaseService _dataBaseService = DataBaseService();

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  /// 1 Obtain a list of the available cameras on the device.
  /// 2 loads the face net model
  _startUp() async {
    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceNetService.loadModel();
    await _faceNetServiceCopy.loadModel();
    await _dataBaseService.loadDB();
    await _dataBaseService.cleanDB();

    _mlKitService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.menu),
        //   color: Colors.black,
        // ),
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color.fromARGB(255, 221, 226, 240),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProfile(widget._userViewmodel)),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 20),
                      Expanded(child: Text('Edit Profile')),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              if (widget._userViewmodel.user.cVerifyStatus == "Unverified")
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Color.fromARGB(255, 221, 226, 240),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/verifyID');
                    },
                    child: Row(
                      children: [
                        Icon(Icons.verified),
                        SizedBox(width: 20),
                        Expanded(child: Text('Verify Identity')),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color.fromARGB(255, 221, 226, 240),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MembershipForm(widget._userViewmodel)),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.credit_card),
                      SizedBox(width: 20),
                      Expanded(child: Text('Apply Gym Membership')),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Color.fromARGB(255, 221, 226, 240),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('user');

                    Navigator.pushNamed(context, '/login');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 20),
                      Expanded(child: Text('Log out')),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
