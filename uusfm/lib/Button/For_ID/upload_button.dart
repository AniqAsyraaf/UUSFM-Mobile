import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

Widget uploadButton({
  String title,
  IconData icon,
  VoidCallback onClicked,
}) =>
    Expanded(
      flex: 8,
      child: DottedBorder(
        color: Colors.orange[700],
        strokeWidth: 2.4,
        dashPattern: [6, 4],
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              minimumSize: Size.fromHeight(200),
              primary: Colors.white,
              textStyle: TextStyle(fontSize: 20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage('assets/camera_icon.png'),
                size: 50,
                color: Colors.black,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          onPressed: onClicked,
        ),
      ),
    );
