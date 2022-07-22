import 'dart:io';

class matricCard {
  String _matricNo;
  String _name;
  String _expDate;
  File _IDImageFront;
  File _IDImageBack;
  File _FaceIDPic;
  String _FaceIDPicNo;

  String _errorMessage = "Wrong document(s)! ,  Please retake the photo";

  String get matricNo => _matricNo;

  String get name => _name;

  String get expDate => _expDate;

  File get IDImageFront => _IDImageFront;

  File get IDImageBack => _IDImageBack;

  File get FaceIDPic => _FaceIDPic;

  String get FaceIDPicNo => _FaceIDPicNo;

  String get errorMessage => _errorMessage;

  set matricNo(String value) {
    _matricNo = value;
  }

  set name(String value) {
    _name = value;
  }

  set expDate(String value) {
    _expDate = value;
  }

  set errorMessage(String value) {
    _errorMessage = value;
  }

  set IDImageFront(File value) {
    _IDImageFront = value;
  }

  set IDImageBack(File value) {
    _IDImageBack = value;
  }

  set FaceIDPic(File value) {
    _FaceIDPic = value;
  }

  set FaceIDPicNo(String value) {
    _FaceIDPicNo = value;
  }
}
