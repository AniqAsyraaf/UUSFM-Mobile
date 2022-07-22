import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:uusfm/Button/For_ID/submitButton.dart';
import 'package:uusfm/Button/For_ID/theme_helper.dart';
import 'package:uusfm/app/router.dart';

import 'package:uusfm/model/matricCard.dart';
import 'package:uusfm/model/user.dart';
import 'package:uusfm/service/facenet.service.dart';
import 'package:uusfm/service/ml_kit_service.dart';

// ignore: must_be_immutable
class textView extends StatefulWidget {
  final matricCard matricCardDetails;
  final File faceImage;
  final User user;
  static Route route() => MaterialPageRoute(builder: (context) => textView());
  textView({this.faceImage, key, this.matricCardDetails, this.user})
      : super(key: key);

  @override
  State<textView> createState() => _textViewState(matricCardDetails);
}

class _textViewState extends State<textView> {
  final matricCard matricCardDetails;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  CameraDescription cameraDescription;
  MLKitService _mlKitService = MLKitService();
  FaceNetService _faceNetService = FaceNetService();

  TextEditingController matricNoController;
  TextEditingController expDateController;
  TextEditingController nameController;

  _textViewState(this.matricCardDetails) {
    nameController = TextEditingController(text: matricCardDetails.name);
    matricNoController =
        TextEditingController(text: matricCardDetails.matricNo);
    expDateController = TextEditingController(text: matricCardDetails.expDate);
  }

  @override
  void initState() {
    super.initState();

    _startUp();
  }

  _startUp() async {
    // _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services

    await _faceNetService.loadModel();

    _mlKitService.initialize();

    // _setLoading(false);
  }

  // shows or hides the circular progress indicator
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.orange[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    _textField('Full Name', widget.matricCardDetails.name,
                        nameController),
                    SizedBox(height: 15),
                    _textField('Matric Number',
                        widget.matricCardDetails.matricNo, matricNoController),
                    SizedBox(height: 15),
                    _textField('Exp Date', widget.matricCardDetails.expDate,
                        expDateController),
                    SizedBox(height: 10),
                    _imageField(widget.matricCardDetails.FaceIDPic),
                    Center(
                      child: Text('ID Photo'),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SubmitButton(
        title: 'Next',
        size: size,
        onClicked: onTap,
      ),
    ));
  }

  void onTap() {
    widget.matricCardDetails.name = nameController.text;
    widget.matricCardDetails.matricNo = matricNoController.text;
    widget.matricCardDetails.expDate = expDateController.text;
    widget.matricCardDetails.name = nameController.text;
    widget.user.cName = nameController.text;
    debugPrint('Matric Card Details : ' + widget.matricCardDetails.toString());
    Navigator.of(context).pushNamed('/faceCapture',
        arguments: faceImageArguments(widget.faceImage, cameraDescription,
            widget.matricCardDetails, widget.user));
  }

  Widget _textField(String title, text, TextEditingController controller) =>
      Container(
        child: TextFormField(
          controller: controller,
          decoration: ThemeHelper().textInputDecoration(title, ''),
        ),
        decoration: ThemeHelper().inputBoxDecorationShaddow(),
      );

  Widget _imageField(File imageFile) => Image.file(imageFile, fit: BoxFit.fill);
}
