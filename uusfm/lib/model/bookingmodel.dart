// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(
    json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
  BookingModel({
    this.id,
    this.cId,
    this.cName,
    this.sessionId,
    this.sessionType,
    this.bookDate,
    this.bookTime,
    this.phoneNum,
    this.bookAttendance,
    this.bookingStatus,
    this.bookingReceipt,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String cId;
  String cName;
  String sessionId;
  String sessionType;
  DateTime bookDate;
  String bookTime;
  String phoneNum;
  String bookAttendance;
  String bookingStatus;
  dynamic bookingReceipt;
  DateTime createdAt;
  DateTime updatedAt;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        cId: json["cID"],
        cName: json["cName"],
        sessionId: json["sessionID"],
        sessionType: json["sessionType"],
        bookDate: DateTime.parse(json["bookDate"]),
        bookTime: json["bookTime"],
        phoneNum: json["phoneNum"],
        bookAttendance: json["bookAttendance"],
        bookingStatus: json["bookingStatus"],
        bookingReceipt: json["bookingReceipt"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cID": cId,
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
