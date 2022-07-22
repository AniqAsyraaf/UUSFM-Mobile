import 'package:flutter/material.dart';

Widget SubmitButton({
  String title,
  VoidCallback onClicked,
  Size size,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            height: size.height / 19,
            padding: EdgeInsets.fromLTRB(100, 0, 70, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              child: Text(title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              onPressed: onClicked,
            ),
          ),
        )
      ],
    );
