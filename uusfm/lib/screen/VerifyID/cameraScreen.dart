import 'dart:io';
// import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  int _pointers = 0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;

  String _text = '';

  Future initCamera(CameraDescription cameraDescription) async {
    // if (cameraController != null) {
    //   await cameraController.dispose();
    // }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      await cameraController.initialize();
    } catch (e) {
      String errorText = 'Error ${e.code} \nError message: ${e.description}';
    }

    if (mounted) {
      setState(() {});
    }
  } //initCamera

  Widget cameraPreview() {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    } else {
      var camera = cameraController.value;
      final size = MediaQuery.of(this.context).size;
      final deviceRatio = size.width / size.height;
      print('Device ratio is $deviceRatio');
      print('Camera ratio is ${camera.aspectRatio}');
      var scale = size.aspectRatio * camera.aspectRatio;
      //print('Camera ratio is ${cameraController.value.aspectRatio}');
      print('Scale is ${scale}');
      var transScale = cameraController.value.aspectRatio / deviceRatio;
      print('Transformed Scale is $transScale');
      //if (scale < 1) scale = 0.5 / scale;
      return Transform.scale(
        scale: 1.5,
        // cameraController.value.aspectRatio /    deviceRatio, //camera.aspectRatio , //
        child: Align(
          alignment: Alignment.center,
          child: CameraPreview(cameraController),
        ),
      );
    }
    /*var camera = cameraController.value;
    // fetch screen size
    final size = MediaQuery
        .of(context)
        .size;
    final deviceRatio = size.width / size.height;
    var scale = size.aspectRatio * camera.aspectRatio;
    //if (scale < 1) scale = 1 / scale;
    return Transform.scale(
      scale: cameraController.value.aspectRatio/deviceRatio,
      child: Center(
        child: CameraPreview(cameraController),
      ),
    );*/
  } //cameraPreview

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (cameraController == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await cameraController.setZoomLevel(_currentScale);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (cameraController == null) {
      return;
    }
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: 65,
              child: FittedBox(
                child: FloatingActionButton(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  elevation: 0,
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    onCapture(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  } //cameraControl

  Widget cameraToggle() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
            onPressed: () {
              onSwitchCamera();
            },
            icon: Icon(
              getCameraLensIcons(lensDirection),
              color: Colors.orange,
              size: 33,
            ),
            label: Text(
              '${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1).toUpperCase()}',
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            )),
      ),
    );
  } //cameraToggle

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermission();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        setState(() {
          selectedCameraIndex = 0;
        });
        initCamera(cameras[selectedCameraIndex]).then((value) {});
      } else {
        print('No camera available');
      }
    }).catchError((e) {
      print('Error : ${e.code}');
    });
  } //initState

  onCapture(context) async {
    try {
      final p = await getApplicationDocumentsDirectory();
      final name = DateTime.now();
      final imagepicker = ImagePicker();

      File newImage;
      //final path = "${p.path}/$name.png";
      final Directory _appDocDirFolder = Directory('${p.path}/flutterEKYC');
      String fullPath = '';
      if (await _appDocDirFolder.exists()) {
        //if folder already exists return path
        print(fullPath);
        fullPath = "${_appDocDirFolder.path}/$name.png";
      } else {
        //if folder not exists create folder and then return its path
        final Directory _appDocDirNewFolder =
            await _appDocDirFolder.create(recursive: true);
        fullPath = "${_appDocDirNewFolder.path}/$name.png";
      }
      //File a= new File(fullPath);
      //final image = await imagepicker.pickImage(source: ImageSource.camera);

      final image = await cameraController.takePicture();
      //final String imagePath = image.path.toString();
      newImage = File(image.path);

      // int x = 100;
      // int y = 220;
      // int w = 525;
      // int h = 900;

      // img.Image originalImage =
      //     img.decodeImage(File(newImage.path).readAsBytesSync());
      // img.Image croppedImage = img.copyCrop(originalImage, x, y, w, h);
      // img.Image rotatedImage = img.copyRotate(croppedImage, -90);
      // newImage.writeAsBytesSync(img.encodeJpg(rotatedImage));

      //save image to gallery
      //_saveImage(image.path);

      Navigator.pop(context, newImage.path);
    } catch (e) {
      print(e);
    }
  } //onCapture

  getCameraLensIcons(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return Icons.switch_camera;
      case CameraLensDirection.front:
        return Icons.switch_camera;
      case CameraLensDirection.external:
        return Icons.camera_alt_rounded;
      default:
        return Icons.device_unknown;
    }
  } //getCameraLensIcons

  onSwitchCamera() {
    selectedCameraIndex =
        selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCamera(selectedCamera);
  } //onSwitchCamera

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: FractionalOffset(0.5, 0.3),
              child: ClipRRect(
                child: Container(
                  width: size.width / 1.1,
                  height: size.height / 1.3,
                  child: cameraPreview(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 130,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    cameraToggle(),
                    cameraControl(context),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset(0.5, -0.2),
            )
          ],
        ),
      ),
    );
  } //build

  void _saveImage(path) async {
    // await GallerySaver.saveImage(path);
    //print(result);
    // Fluttertoast.showToast(
    //     msg: 'Saved to Gallery', toastLength: Toast.LENGTH_LONG);
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    //Fluttertoast.showToast(msg:'Permission Granted',toastLength: Toast.LENGTH_LONG);
  }

  Widget buildUpCameraOverlay() {
    print('buildUpCameraCalled');

    ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
      child: Container(
        color: Colors.orange,
        width: 300,
        height: 300,
        //  decoration: BoxDecoration(
        //    border: Border.all(width: 0, color: Colors.blue),
        // ),
        margin: EdgeInsets.only(top: 100),
        //child: cameraPreview(),
      ),
    );
  }

  /** found on github for capturing credit card
   *  Size size = MediaQuery.of(context).size;
      if (_controller == null || !_controller.value.isInitialized) {
      return _placeHolder();
      } else {
      return GestureDetector(
      onTap: () => onTakePictureButtonPressed(),
      child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: AspectRatio(
      aspectRatio: 1.586,
      child: OverflowBox(
      alignment: Alignment.center,
      child: FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
      width: size.width,
      height: size.height / 1.586,
      child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
      CameraPreview(_controller),
      IconButton(icon: Icon(Icons.camera_alt, size: 50), onPressed: null),
      ],
      ),
      ),
      ),
      ),
      ),
      ),
      );
      }**/

}
