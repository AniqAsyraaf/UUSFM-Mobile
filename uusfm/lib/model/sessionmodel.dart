// To parse this JSON data, do
//
//     final sessionModel = sessionModelFromJson(jsonString);

import 'dart:convert';

List<SessionModel> sessionModelFromJson(String str) => List<SessionModel>.from(
    json.decode(str).map((x) => SessionModel.fromJson(x)));

String sessionModelToJson(List<SessionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SessionModel {
  SessionModel({
    this.id,
    this.sessionDate,
    this.sessionTime,
    this.sessionCapacity,
    this.sessionGuestCap,
    this.sessionCurrCap,
    this.sessionCurrGuestCap,
    this.sessionDesc,
    this.sessionType,
    this.sessionStatus,
    this.sessionDay,
    this.mcId,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String sessionDate;
  String sessionTime;
  String sessionCapacity;
  String sessionGuestCap;
  String sessionCurrCap;
  String sessionCurrGuestCap;
  String sessionDesc;
  String sessionType;
  String sessionStatus;
  String sessionDay;
  String mcId;
  DateTime createdAt;
  DateTime updatedAt;

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        id: json["id"],
        sessionDate: json["sessionDate"],
        sessionTime: json["sessionTime"],
        sessionCapacity: json["sessionCapacity"],
        sessionGuestCap: json["sessionGuestCap"],
        sessionCurrCap: json["sessionCurrCap"],
        sessionCurrGuestCap: json["sessionCurrGuestCap"],
        sessionDesc: json["sessionDesc"],
        sessionType: json["sessionType"],
        sessionStatus: json["sessionStatus"],
        sessionDay: json["sessionDay"],
        mcId: json["mcID"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sessionDate": sessionDate,
        // "${sessionDate.year.toString().padLeft(4, '0')}-${sessionDate.month.toString().padLeft(2, '0')}-${sessionDate.day.toString().padLeft(2, '0')}",
        "sessionTime": sessionTime,
        "sessionCapacity": sessionCapacity,
        "sessionGuestCap": sessionGuestCap,
        "sessionCurrCap": sessionCurrCap,
        "sessionCurrGuestCap": sessionCurrGuestCap,
        "sessionDesc": sessionDesc,
        "sessionType": sessionType,
        "sessionStatus": sessionStatus,
        "sessionDay": sessionDay,
        "mcID": mcId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
