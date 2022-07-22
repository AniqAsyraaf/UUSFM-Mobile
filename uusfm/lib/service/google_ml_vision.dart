import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image/image.dart' as img;
import 'package:uusfm/model/matricCard.dart';
import 'package:uusfm/service/facenet.service.copy.dart';

Rect rectangle;

class GoogleMLVision {
  static Future<matricCard> recogniseText(File imageFile) async {
    final visionImage = InputImage.fromFile(imageFile);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
        await textDetector.processImage(visionImage);
    await textDetector.close();

    final matricCard _matricCard = extractText(recognisedText);
    //return text.isEmpty ? 'No text found in the image' : text;
    debugPrint(_matricCard.matricNo);
    debugPrint(_matricCard.expDate);

    return _matricCard;
  }

  static Future<File> recogniseFace(File imageFile) async {
    FaceNetServiceCopy _faceNetServiceCopy = FaceNetServiceCopy();
    final visionImage = InputImage.fromFile(imageFile);
    final faceDetector = GoogleMlKit.vision.faceDetector();
    List<Face> faces = await faceDetector.processImage(visionImage);

    debugPrint(imageFile.toString());
    debugPrint(faces[0].toString());
    _faceNetServiceCopy.setCurrentPrediction(imageFile, faces[0]);

    List<Map<String, int>> faceMaps = [];
    int i = 0;

    for (Face face in faces) {
      int x = face.boundingBox.left.toInt();
      int y = face.boundingBox.top.toInt();
      int w = face.boundingBox.width.toInt();
      int h = face.boundingBox.height.toInt();
      print('face width : ' + w.toString());

      //Face Map
      Map<String, int> thisMap = {
        'x': x - 12,
        'y': y - 50,
        'w': w + 25,
        'h': h + 100,
      };

      faceMaps.add(thisMap);
    }

    img.Image originalImage =
        img.decodeImage(File(imageFile.path).readAsBytesSync());
    img.Image faceCrop = img.copyCrop(originalImage, faceMaps[i]['x'],
        faceMaps[i]['y'], faceMaps[i]['w'], faceMaps[i]['h']);

    imageFile.writeAsBytesSync(img.encodeJpg(faceCrop));

    return imageFile;
  }

  static Future<String> recogniseTextFromBack(File imageFile) async {
    final visionImage = InputImage.fromFile(imageFile);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
        await textDetector.processImage(visionImage);
    await textDetector.close();

    String fullname = extractNameFromBack(recognisedText);
    debugPrint('Back name = ' + fullname);
    return fullname;
  }

  static String extractNameFromBack(RecognisedText visionText) {
    bool isNameNext = false;
    bool isUppercase(String text) {
      return text == text.toUpperCase();
    }

    String tempname = "";

    matricCard _matricCardDetails = matricCard();

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        //debugPrint(line.text);

        if (isNameNext) {
          if (isUppercase(line.text) == true) {
            if (!line.text.contains('0')) {
              //debugPrint(line.text);

              tempname = tempname + " " + line.text;
              debugPrint(_matricCardDetails.name);
            } else {
              isNameNext = false;
            }
            _matricCardDetails.name = tempname;
          }

          //print(_matricCardDetails.name);
        }
        if (line.text.contains("ame")) {
          isNameNext = true;
        }
        for (TextElement word in line.elements) {}
      }
    }

    return _matricCardDetails.name;
  }

  static extractText(RecognisedText visionText) {
    String text = '';
    bool isNameNext = false;
    bool isExpDateNext = false;
    String lastword = '';
    List<Offset> cornerPoints;

    matricCard _matricCardDetails = matricCard();

    String extractICNumber(String selectedWord) {
      if (selectedWord != null &&
          selectedWord.length == 12 &&
          selectedWord.contains("J", 0) &&
          selectedWord.contains("B", 1) &&
          selectedWord.contains(" ", 2)) {
        isExpDateNext = true;

        _matricCardDetails.matricNo = selectedWord.toUpperCase();
        debugPrint(_matricCardDetails.matricNo);
        // print(cornerPoints);
        // print(rectangle);
      }
      return null;
    }

    String extractExpDate(String line) {
      if (isExpDateNext) {
        _matricCardDetails.expDate = line;
        //print(_matricCardDetails.expDate);
        isExpDateNext = false;
      }
      return null;
    }

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        String selectedBlock;
        String selectedLine;
        selectedBlock = block.text;
        selectedLine = line.text;

        //debugPrint('asda' + selectedBlock);
        // debugPrint(selectedLine);

        extractExpDate(selectedLine);
        extractICNumber(selectedLine);
        for (TextElement word in line.elements) {
          String selectedWord = word.text;
          String lineInWord = line.text;
          // extractICNumber(selectedWord);
        }
      }
    }

    if (_matricCardDetails.matricNo == null) {
      _matricCardDetails.matricNo = '';
    }

    if (_matricCardDetails.expDate == null) {
      _matricCardDetails.expDate = '';
    }

    // debugPrint("IC : " + _matricCardDetails.icNumber);
    // debugPrint("name : " + _matricCardDetails.name);
    // debugPrint("address : " + _matricCardDetails.address);
    // debugPrint("Nationality : " + _matricCardDetails.nationality);
    // debugPrint("Religion : " + _matricCardDetails.religion);
    // debugPrint("Gender : " + _matricCardDetails.gender);
    return _matricCardDetails;
  }
}
