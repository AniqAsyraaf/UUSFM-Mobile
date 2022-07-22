// A screen that allows users to take a picture using a given camera.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';
import 'package:selfie_ocr_mtpl/selfie_ocr_mtpl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uusfm/app/router.dart';
import 'package:uusfm/database/database.dart';
import 'package:uusfm/model/matricCard.dart';
import 'package:uusfm/model/sessionmodel.dart';
import 'dart:math' as math;

import 'package:uusfm/model/user.dart';
import 'package:uusfm/model/usermodel.dart';
import 'package:uusfm/screen/Register/Register.dart';
import 'package:uusfm/screen/VerifyID/verifyID.dart';
import 'package:uusfm/screen/login/FacePainter.dart';
import 'package:uusfm/service/camera.service.dart';
import 'package:uusfm/service/facenet.service.dart';
import 'package:uusfm/service/ml_kit_service.dart';
import 'package:uusfm/viewmodel/registerviewmodel.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

class faceCapture extends StatefulWidget {
  final CameraDescription cameraDescription;
  final File faceimage;
  final User user;
  final matricCard matricCardDetails;
  faceCapture({
    Key key,
    @required this.faceimage,
    this.cameraDescription,
    this.user,
    this.matricCardDetails,
  }) : super(key: key);

  @override
  _faceCapture createState() => _faceCapture();
}

class _faceCapture extends State<faceCapture> {
  /// Service injection
  CameraService _cameraService = CameraService();
  MLKitService _mlKitService = MLKitService();
  FaceNetService _faceNetService = FaceNetService();
  DataBaseService _dataBaseService = DataBaseService();

  Future _initializeControllerFuture;
  bool cameraInitializated = false;
  bool _detectingFaces = false;
  bool pictureTaked = false;

  // switchs when the user press the camera
  bool _saving = false;
  bool _bottomSheetVisible = false;

  String imagePath;
  Size imageSize;
  Face faceDetected;

  @override
  void initState() {
    super.initState();

    /// starts the camera & start framing faces
    _start();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraService.dispose();
    super.dispose();
  }

  /// starts the camera & start framing faces
  _start() async {
    _initializeControllerFuture =
        _cameraService.startService(widget.cameraDescription);
    await _initializeControllerFuture;

    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    _mlKitService.initialize();

    setState(() {
      cameraInitializated = true;
    });

    _frameFaces();
  }

  /// draws rectangles when detects faces
  _frameFaces() {
    imageSize = _cameraService.getImageSize();

    _cameraService.cameraController.startImageStream((image) async {
      if (_cameraService.cameraController != null) {
        // if its currently busy, avoids overprocessing
        if (_detectingFaces) return;

        _detectingFaces = true;

        try {
          List<Face> faces = await _mlKitService.getFacesFromImage(image);

          if (faces != null) {
            if (faces.length > 0) {
              // preprocessing the image
              setState(() {
                faceDetected = faces[0];
              });

              if (_saving) {
                _saving = false;
                _faceNetService.setCurrentPrediction(image, faceDetected);
              }
            } else {
              setState(() {
                faceDetected = null;
              });
            }
          }

          _detectingFaces = false;
        } catch (e) {
          print(e);
          _detectingFaces = false;
        }
      }
    });
  }

  Future VerifyUser(String id) async {
    print("wowowwoooow");
    Registerviewmodel _Registerviewmodel = Registerviewmodel();

    String res = await _Registerviewmodel.verifyUser(id);
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
      //       builder: (context) => EditRegister(widget._userViewmodel)),
      // );
    }
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(ySnackBar);
    // }
  }

  /// handles the button pressed event
  Future<void> onShot() async {
    if (faceDetected == null) {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 1, milliseconds: 250), () {
              Navigator.of(context).pop(true);
            });
            return _showDialog('No Face Detected');
          });

      return false;
    } else {
      _saving = true;
      await Future.delayed(Duration(milliseconds: 500));
      await _cameraService.cameraController.stopImageStream();
      await Future.delayed(Duration(milliseconds: 200));
      // XFile file = await _cameraService.takePicture();
      // File fail = File(file.path);

      var userAndPass = _faceNetService.predict();

      if (userAndPass != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String username = preferences.getString('user');

        String id = username.substring(7, username.indexOf(","));
        String idNew = id.substring(0, id.length - 1);

        // VerifyUser(idNew);
        Registerviewmodel _Registerviewmodel = Registerviewmodel();

        String res = await _Registerviewmodel.verifyUser(idNew);

        if (res == "success") {
          //await getCustData;
          print('asda');
          var RegisterSnackBar = const SnackBar(
            content: Text('Successfully verified!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(RegisterSnackBar);
        }

        showDialog(
            context: context,
            builder: (context) {
              return _showDialog('User Authenticated');
            });

        if (true) {
          Future.delayed(Duration(seconds: 1, milliseconds: 250), () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 4);
          });
        }
      } else {
        showDialog(
            context: context,
            builder: (context) {
              Future.delayed(Duration(seconds: 1, milliseconds: 250), () {
                Navigator.of(context).pop(true);
              });
              return _showDialog('Face is not matched with IC picture');
            });
        _frameFaces();
      }

      return true;
    }
  }

  // _onBackPressed() {
  //   Navigator.of(context).pop();
  // }

  _reload() {
    setState(() {
      _bottomSheetVisible = false;
      cameraInitializated = false;
      pictureTaked = false;
    });
    this._start();
  }

  _showDialog(String text) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Container(
          height: 50,
          width: 25,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ]),
        ),
        backgroundColor: Colors.orangeAccent,
      );

  @override
  Widget build(BuildContext context) {
    final double mirror = math.pi;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.orange[300],
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      height: height,
                      width: width,
                      color: Colors.white,
                    ),
                    FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (pictureTaked) {
                              return Container(
                                width: width,
                                height: height,
                                child: Transform(
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.file(File(imagePath)),
                                    ),
                                    transform: Matrix4.rotationY(mirror)),
                              );
                            } else {
                              return Transform.scale(
                                scale: 1.0,
                                child: AspectRatio(
                                  aspectRatio:
                                      MediaQuery.of(context).size.aspectRatio,
                                  child: OverflowBox(
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      alignment: Alignment(0.1, -0.7),
                                      fit: BoxFit.none,
                                      //camera sini
                                      child: Align(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(200.0)),
                                          child: Container(
                                            color: Colors.blueAccent,
                                            width: 280,
                                            height: 250 *
                                                _cameraService.cameraController
                                                    .value.aspectRatio,
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: <Widget>[
                                                CameraPreview(_cameraService
                                                    .cameraController),
                                                CustomPaint(
                                                  painter: FacePainter(
                                                      face: faceDetected,
                                                      imageSize: imageSize),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 30,
            ),
            backgroundColor: Colors.orange,
            onPressed: onShot,
          )),
    );
  }
}
