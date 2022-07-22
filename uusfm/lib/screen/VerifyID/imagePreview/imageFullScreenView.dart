import 'dart:io';

import 'package:flutter/material.dart';

class imageFullScreenPage extends StatelessWidget {
  final String image;
  final File imageFile;
  static Route route() =>
      MaterialPageRoute(builder: (context) => imageFullScreenPage());
  const imageFullScreenPage({this.image, this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Preview Image',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (image == null)
                    ? Image.file(imageFile, fit: BoxFit.fill)
                    : Image.asset(image, fit: BoxFit.fill),
              ]),
        ),
      ),
    );
  }
}
