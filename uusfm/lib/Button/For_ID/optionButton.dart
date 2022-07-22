import 'package:flutter/material.dart';

Widget optionButton({
  String title,
  IconData icon,
  VoidCallback onClicked,
}) =>
    Expanded(
      flex: 2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(100),
            primary: Colors.white,
            textStyle: TextStyle(fontSize: 20)),
        child: Column(
          children: [
            ImageIcon(
              AssetImage('assets/camera_icon.png'),
              size: 25,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        onPressed: onClicked,
      ),
    );
