// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.id,
    this.cName,
    this.cPassword,
    this.cEmail,
    this.cPhoneNum,
    this.cFaceImage,
    this.cMatricImage,
    this.cRole,
    this.cVerifyStatus,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String cName;
  String cPassword;
  String cEmail;
  String cPhoneNum;
  dynamic cFaceImage;
  dynamic cMatricImage;
  String cRole;
  String cVerifyStatus;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        cName: json["cName"],
        cPassword: json["cPassword"],
        cEmail: json["cEmail"],
        cPhoneNum: json["cPhoneNum"],
        cFaceImage: json["cFaceImage"],
        cMatricImage: json["cMatricImage"],
        cRole: json["cRole"],
        cVerifyStatus: json["cVerifyStatus"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cName": cName,
        "cPassword": cPassword,
        "cEmail": cEmail,
        "cPhoneNum": cPhoneNum,
        "cFaceImage": cFaceImage,
        "cMatricImage": cMatricImage,
        "cRole": cRole,
        "cVerifyStatus": cVerifyStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
