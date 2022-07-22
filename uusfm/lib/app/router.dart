import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uusfm/main.dart';
import 'package:uusfm/model/matricCard.dart';
import 'package:uusfm/model/user.dart';
import 'package:uusfm/screen/Booking/Gymnasium.dart';
import 'package:uusfm/screen/Main/mainscreen.dart';
import 'package:uusfm/screen/VerifyID/backCameraScreen.dart';
import 'package:uusfm/screen/VerifyID/cameraScreen.dart';
import 'package:uusfm/screen/VerifyID/imagePreview/textView.dart';
import 'package:uusfm/screen/VerifyID/verifyID.dart';
import 'package:uusfm/screen/faceVerify/faceCapture.dart';
import 'package:uusfm/screen/register/register.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

import '../screen/login/login.dart';

Route<dynamic> createRoute(settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case '/':
    case '/login':
      return Login.route();
    case '/register':
      return SignUpScreen.route();
    // case '/bookGym':
    //   return MaterialPageRoute(builder: (_) => Gymnasium());
    // case '/bookStadium':
    //   return MaterialPageRoute(builder: (_) => Stadium());
    // case '/bookFootball':
    //   return MaterialPageRoute(builder: (_) => FootballField());
    case '/verifyID':
      return MaterialPageRoute(builder: (_) => VerifyID());
    case '/cameraScreen':
      return MaterialPageRoute(builder: (_) => CameraScreen());
    case '/backCameraScreen':
      return MaterialPageRoute(builder: (_) => BackCameraScreen());
    case '/textView':
      return MaterialPageRoute(builder: (_) {
        TextViewArguments arguments = args;
        return textView(
          matricCardDetails: arguments._matricCard,
          faceImage: arguments._imageFile,
          user: arguments._user,
        );
      });
    case '/faceCapture':
      return MaterialPageRoute(builder: (_) {
        faceImageArguments arguments = args;
        return faceCapture(
          faceimage: arguments.faceimage,
          cameraDescription: arguments.cameraDescription,
          matricCardDetails: arguments._matricCard,
          user: arguments.user,
        );
      });
  }
  return null;
}

class TextViewArguments {
  final matricCard _matricCard;
  final File _imageFile;
  final User _user;

  TextViewArguments(this._matricCard, this._imageFile, this._user);
}

class matricCardAndUserArguments {
  final matricCard _matricCard;
  final User _user;

  matricCardAndUserArguments(this._matricCard, this._user);
}

class CameraFilePreviewArguments {
  final File imageFile;
  final matricCard _matricCard;
  final User _user;

  CameraFilePreviewArguments(this.imageFile, this._matricCard, this._user);
}

class faceImageArguments {
  final File faceimage;
  final CameraDescription cameraDescription;
  final matricCard _matricCard;
  final User user;

  faceImageArguments(
      this.faceimage, this.cameraDescription, this._matricCard, this.user);
}
