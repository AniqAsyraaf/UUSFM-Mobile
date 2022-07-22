import 'package:flutter/material.dart';

Widget previewButton({
  String title,
  IconData icon,
  VoidCallback onClicked,
  String imagePath,
}) =>
    Expanded(
        flex: 3,
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Image.asset(imagePath),
            ],
          ),
        )
        // OutlinedButton(
        //   style: OutlinedButton.styleFrom(
        //       minimumSize: Size.fromHeight(200),
        //       primary: Colors.white,
        //       textStyle: TextStyle(fontSize: 20)),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Icon(icon, size: 28, color: Colors.black),
        //       Text(title, style: TextStyle(fontSize: 15, color: Colors.black)),
        //       const SizedBox(height: 20),
        //       Image.asset(imagePath),
        //     ],
        //   ),
        //   onPressed: onClicked,
        // ),
        );
