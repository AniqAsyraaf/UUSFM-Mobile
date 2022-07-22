// To parse this JSON data, do
//
//     final membershipModel = membershipModelFromJson(jsonString);

import 'dart:convert';

List<MembershipModel> membershipModelFromJson(String str) =>
    List<MembershipModel>.from(
        json.decode(str).map((x) => MembershipModel.fromJson(x)));

String membershipModelToJson(List<MembershipModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MembershipModel {
  MembershipModel({
    this.id,
    this.cId,
    this.membershipType,
    this.membershipEntry,
    this.membershipExpired,
    this.membershipStatus,
    this.membershipReceipt,
    this.createdAt,
    this.updatedAt,
    this.cName,
    this.sessionId,
    this.sessionType,
    this.bookDate,
    this.bookTime,
    this.phoneNum,
    this.bookAttendance,
    this.bookingStatus,
    this.bookingReceipt,
  });

  String id;
  String cId;
  String membershipType;
  dynamic membershipEntry;
  String membershipExpired;
  String membershipStatus;
  dynamic membershipReceipt;
  DateTime createdAt;
  DateTime updatedAt;
  String cName;
  String sessionId;
  String sessionType;
  DateTime bookDate;
  String bookTime;
  String phoneNum;
  String bookAttendance;
  String bookingStatus;
  dynamic bookingReceipt;

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      MembershipModel(
        id: json["id"],
        cId: json["cID"],
        membershipType: json["membershipType"],
        membershipEntry: json["membershipEntry"],
        membershipExpired: json["membershipExpired"],
        membershipStatus: json["membershipStatus"],
        membershipReceipt: json["membershipReceipt"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        cName: json["cName"],
        sessionId: json["sessionID"],
        sessionType: json["sessionType"],
        bookDate: DateTime.parse(json["bookDate"]),
        bookTime: json["bookTime"],
        phoneNum: json["phoneNum"],
        bookAttendance: json["bookAttendance"],
        bookingStatus: json["bookingStatus"],
        bookingReceipt: json["bookingReceipt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cID": cId,
        "membershipType": membershipType,
        "membershipEntry": membershipEntry,
        "membershipExpired": membershipExpired,
        "membershipStatus": membershipStatus,
        "membershipReceipt": membershipReceipt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "cName": cName,
        "sessionID": sessionId,
        "sessionType": sessionType,
        "bookDate":
            "${bookDate.year.toString().padLeft(4, '0')}-${bookDate.month.toString().padLeft(2, '0')}-${bookDate.day.toString().padLeft(2, '0')}",
        "bookTime": bookTime,
        "phoneNum": phoneNum,
        "bookAttendance": bookAttendance,
        "bookingStatus": bookingStatus,
        "bookingReceipt": bookingReceipt,
      };
}
