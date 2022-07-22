// import 'dart:io';
// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
// import 'package:path/path.dart';
// import 'package:uusfm/model/matricCard.dart';
// import 'package:uusfm/model/user.dart';

// class FirebaseApi {
//   static UploadTask uploadFile(String destination, File file) {
//     try {
//       final ref = FirebaseStorage.instance.ref(destination);

//       return ref.putFile(file);
//     } on FirebaseException catch (e) {
//       return null;
//     }
//   }

//   static File changeFileNameOnlySync(File file, String newFileName) {
//     var path = file.path;
//     var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
//     var newPath = path.substring(0, lastSeparator + 1) + newFileName;
//     return file.renameSync(newPath);
//   }

//   static uploadToFirebase(
//       matricCard matricCard, User user, BuildContext context) async {
//     firebaseUser.User getCurrentUserData =
//         firebaseUser.FirebaseAuth.instance.currentUser;

//     user.cEmail = getCurrentUserData.email;
//     user.cName = matricCard.name;

//     UploadTask task1;
//     UploadTask task2;
//     UploadTask task3;
//     UploadTask task4;
//     UploadTask task5;

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     //get Timestamp
//     DateTime now = DateTime.now();

//     //change file name
//     final ICFrontName =
//         changeFileNameOnlySync(matricCard.IDImageFront, 'IC_Front.jpg');
//     final ICBackName =
//         changeFileNameOnlySync(matricCard.IDImageBack, 'IC_Back.jpg');
//     final ICFacePic =
//         changeFileNameOnlySync(matricCard.FaceIDPic, 'IC_FaceImage.jpg');

//     //FILE UPLOAD
//     final fileName1 = basename(ICFrontName.path);
//     final destination1 = '${matricCard.matricNo}/$fileName1';

//     final fileName2 = basename(ICBackName.path);
//     final destination2 = '${matricCard.matricNo}/$fileName2';

//     final fileName3 = basename(ICFacePic.path);
//     final destination3 = '${matricCard.matricNo}/$fileName3';


//     try {
//       task1 = uploadFile(destination1, ICFrontName);
//       task2 = uploadFile(destination2, ICBackName);
//       task3 = uploadFile(destination3, ICFacePic);

//       if (task1 == null) return;
//       if (task2 == null) return;
//       if (task3 == null) return;
//       if (task4 == null) return;
//       if (task5 == null) return;

//       //front IC
//       final snapshot1 = await task1.whenComplete(() {});
//       final downloadUrl1 = await snapshot1.ref.getDownloadURL();

//       //back IC
//       final snapshot2 = await task2.whenComplete(() {});
//       final downloadUrl2 = await snapshot2.ref.getDownloadURL();

//       //Face IC Image
//       final snapshot3 = await task3.whenComplete(() {});
//       final downloadUrl3 = await snapshot3.ref.getDownloadURL();

//       //Signature Image
//       final snapshot4 = await task4.whenComplete(() {});
//       final downloadUrl4 = await snapshot4.ref.getDownloadURL();

//       //Supporting document
//       final snapshot5 = await task5.whenComplete(() {});
//       final downloadUrl5 = await snapshot5.ref.getDownloadURL();

//       //RANDOM NUMBER
//       Random random = new Random();
//       int min = 1, max = 10000;
//       int randomNumber = min + random.nextInt(max - min);

//       //tblCustomerIDInfo
//       await FirebaseFirestore.instance
//           .collection("tblCustomerIDInfo")
//           .doc(matricCard.matricNo)
//           .set({
//         'fldIDNo': matricCard.matricNo,
//         'fldName': matricCard.name,
//         'fldIDImageFront': downloadUrl1,
//         'fldIDImageBack': downloadUrl2,
//         'fldFaceIDPicNo': randomNumber,
//         'fldFaceIDPic': downloadUrl3,
//         'fldCreatedTimestamp':
//             '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}',
//         'fldUpdatedTimestamp':
//             '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}',
//         'fldCreatedby': user.cName,
//         'fldUpdatedby': user.cName,
//       });

//       //tblCustomerAdditionalInfo
//       await FirebaseFirestore.instance
//           .collection("tblCustomerAdditionalInfo")
//           .doc(matricCard.matricNo)
//           .set({
//         'fldGender': user.gender,
//         'fldRace': user.race,
//         'fldMarritalStatus': user.marritalStatus,
//         'fldEmail': user.email,
//         'fldOccupation': 'Test',
//         'fldSignatureImg': downloadUrl4,
//         'fldCreatedTimestamp':
//             '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}',
//         'fldUpdatedTimestamp':
//             '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}',
//         'fldCreatedby': user.cName,
//         'fldUpdatedby': user.cName,
//       });

//       //tblCustomerSupportingDoc
//       await FirebaseFirestore.instance
//           .collection("tblCustomerSupportingDoc")
//           .doc(matricCard.matricNo)
//           .set({
//         'fldSupportDoc': downloadUrl5,
//         'fldCreatedTimestamp':
//             '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}',
//         'fldUpdatedTimestamp':
//             '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}',
//         'fldCreatedby': user.name,
//         'fldUpdatedby': user.name,
//       });

//       //tblCustomerFacialInfo
//       await FirebaseFirestore.instance
//           .collection("tblCustomerFacialInfo")
//           .doc(matricCard.matricNo)
//           .set({
//         'fldFaceIDPicNo': randomNumber,
//         'fldStatus': 'Approved',
//         'fldCreatedTimestamp':
//             '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}',
//         'fldUpdatedTimestamp':
//             '${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}',
//         'fldCreatedby': user.name,
//         'fldUpdatedby': user.name,
//       });
//     } catch (e) {
//       return e.toString();
//     }
//     return 'true';
//   }
// }
