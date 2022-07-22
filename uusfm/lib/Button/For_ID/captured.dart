import 'dart:io';

import 'package:flutter/material.dart';

Widget captured({
  File image,
  VoidCallback viewPhoto,
  VoidCallback retakePhoto,
  Size size,
}) =>
    Stack(alignment: Alignment.center, children: [
      Container(
        height: size.height / 3,
        width: size.width / 1.3,
        child: Material(
            child: InkWell(
          onTap: viewPhoto,
          child: Image.file(image, fit: BoxFit.fitWidth),
        )),
      ),
      Positioned(
        bottom: 0,
        left: 7,
        child: Container(
          height: size.height / 19,
          width: size.width / 2.8,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(30),
              // shape: StadiumBorder(),
              onPrimary: Colors.orange,
              primary: Colors.white,
              textStyle: TextStyle(fontSize: 13),
              shadowColor: Colors.transparent,
              side: BorderSide(width: 1.0, color: Colors.orange),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove_red_eye,
                  size: 20,
                ),
                SizedBox(width: 5),
                Text('View Image')
              ],
            ),
            onPressed: viewPhoto,
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 7,
        child: Container(
          height: size.height / 19,
          width: size.width / 2.7,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
              // shape: StadiumBorder(),
              primary: Colors.orange,
              shadowColor: Colors.transparent,
              textStyle: TextStyle(
                fontSize: 13,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_rounded,
                  size: 15,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  'Retake photo',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            onPressed: retakePhoto,
          ),
        ),
      ),
    ]);
