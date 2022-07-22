import 'dart:io';

import 'package:flutter/material.dart';

import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_compare/image_compare.dart';
import 'package:uusfm/Button/For_ID/captured.dart';
import 'package:uusfm/Button/For_ID/preview.dart';
import 'package:uusfm/Button/For_ID/submitButton.dart';
import 'package:uusfm/Button/For_ID/upload_button.dart';
import 'package:uusfm/app/router.dart';
import 'package:uusfm/database/database.dart';
import 'package:uusfm/model/matricCard.dart';
import 'package:uusfm/model/user.dart';
import 'package:uusfm/screen/VerifyID/imagePreview/imageFullScreenView.dart';
import 'package:uusfm/service/facenet.service.copy.dart';
import 'package:uusfm/service/google_ml_vision.dart';

class VerifyID extends StatefulWidget {
  String imageReceived;

  VerifyID({this.imageReceived, key}) : super(key: key);

  @override
  _VerifyIDState createState() => _VerifyIDState();
}

class _VerifyIDState extends State<VerifyID> {
  String _imagePath;
  String _imagePath2;
  String text = '';
  bool isCompleted = false;
  matricCard _matricCard;
  //ni file ic
  File _faceImage;
  //verify IC from back
  String _backIC;
  User _user = User();
  final DataBaseService _dataBaseService = DataBaseService();
  final FaceNetServiceCopy _faceNetServiceCopy = FaceNetServiceCopy();

  final boxDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(color: Colors.white, spreadRadius: 3),
    ],
  );

  void getImage() async {
    try {
      var result = await Navigator.of(context).pushNamed('/cameraScreen');
      if (result == null) return;
      File image = File(result);
      String LastDigitDirectory = result.toString().replaceAll('.jpg', '');
      File newImage = await image.copy('$LastDigitDirectory new.jpg');
      _faceImage = await GoogleMLVision.recogniseFace(newImage);

      setState(() {
        _imagePath = null;
        _imagePath = image.path;
      });
    } catch (e) {
      setText(e.toString());
      _errorDialog(text);
    }
  }

  Future<void> getImage2() async {
    try {
      var result = await Navigator.of(context).pushNamed('/backCameraScreen');
      if (result == null) return;
      //_backIC = await GoogleMLVision.recogniseTextFromBack(File(result));

      setState(() {
        _imagePath2 = result;
      });
    } catch (e) {
      setText(e.toString());
      _errorDialog(text);
    }
  }

  Future scanDocument() async {
    try {
      _matricCard = await GoogleMLVision.recogniseText(File(_imagePath));

      _matricCard.name =
          await GoogleMLVision.recogniseTextFromBack(File(_imagePath2));

      _matricCard.IDImageFront = File(_imagePath);

      print(_matricCard.IDImageFront);

      _matricCard.IDImageBack = File(_imagePath2);
      print(_matricCard.IDImageBack);

      _matricCard.FaceIDPic = _faceImage;
      List predictedData = _faceNetServiceCopy.predictedData;

      String substringIC = _matricCard.matricNo;

      /// creates a new user in the 'database'
      await _dataBaseService.saveData(substringIC, predictedData);
      print('Predicted data time save  : ' + predictedData.toString());

      /// resets the face stored in the face net sevice
      _faceNetServiceCopy.setPredictedData(null);

      Navigator.of(context).pushNamed('/textView',
          arguments: TextViewArguments(_matricCard, _faceImage, _user));
    } catch (e) {
      setText(
          '     Wrong document(s) / \nCould not capture all details !\n   Please retake the photo');
      _errorDialog(text);
    }
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
  }

  Future<double> compareImage(var src1, var src2) async {
    var assetResult = await compareImages(
        src1: src1, src2: Uri.parse(src2), algorithm: PerceptualHash());
    //perceptualHash for flag
    double num = double.parse((assetResult * 100).toStringAsFixed(3));
    print('difference :  ${num}% ');
    return num;
  }

  File changeFileNameOnlySync(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.renameSync(newPath);
  }

  _errorDialog(String text) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(text),
        ),
        barrierDismissible: true,
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Container(
                  height: size.height,
                  width: size.width,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(50.0),
                      topRight: const Radius.circular(50.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      AspectRatio(
                          aspectRatio: 40 / 9,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                            ),
                          )),
                      // -----------------  BODY --------------------------------//

                      Container(
                        decoration: boxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              (_imagePath == null)
                                  ? uploadButton(
                                      title: 'Capture Front Side',
                                      icon: Icons.camera_alt_outlined,
                                      onClicked: getImage,
                                    )
                                  : captured(
                                      image: File(_imagePath),
                                      viewPhoto: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                imageFullScreenPage(
                                                    image: null,
                                                    imageFile:
                                                        File(_imagePath)),
                                          )),
                                      retakePhoto: getImage,
                                      size: size),
                              SizedBox(width: 5),
                              (_imagePath == null)
                                  ? previewButton(
                                      title: 'Sample',
                                      icon: Icons.remove_red_eye_outlined,
                                      imagePath: 'assets/matric-sample-1.png',
                                      onClicked: () => Navigator.of(context)
                                          .pushNamed('/imageFullScreen',
                                              arguments:
                                                  'assets/matric-sample-1.png'),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: boxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              (_imagePath2 == null)
                                  ? uploadButton(
                                      title: 'Capture Back Side',
                                      icon: Icons.camera_alt_outlined,
                                      onClicked: getImage2,
                                    )
                                  : captured(
                                      image: File(_imagePath2),
                                      viewPhoto: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                imageFullScreenPage(
                                                    image: null,
                                                    imageFile:
                                                        File(_imagePath2)),
                                          )),
                                      retakePhoto: getImage2,
                                      size: size),
                              SizedBox(width: 5),
                              (_imagePath2 == null)
                                  ? previewButton(
                                      title: 'Sample',
                                      icon: Icons.remove_red_eye_outlined,
                                      imagePath: 'assets/matric-sample-2.png',
                                      onClicked: () => Navigator.of(context)
                                          .pushNamed('/imageFullScreen',
                                              arguments:
                                                  'assets/matric-sample-2.png'),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        floatingActionButton: (_imagePath != null && _imagePath2 != null)
            ? SubmitButton(
                title: 'Next',
                onClicked: scanDocument,
                size: size,
              )
            : Container(),
      ),
    );
  }
}
