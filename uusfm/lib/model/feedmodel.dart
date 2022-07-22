// To parse this JSON data, do
//
//     final feedModel = feedModelFromJson(jsonString);

import 'dart:convert';

List<FeedModel> feedModelFromJson(String str) =>
    List<FeedModel>.from(json.decode(str).map((x) => FeedModel.fromJson(x)));

String feedModelToJson(List<FeedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedModel {
  FeedModel({
    this.id,
    this.feedTitle,
    this.feedDesc,
    this.feedCategory,
    this.feedPicture,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String feedTitle;
  String feedDesc;
  String feedCategory;
  dynamic feedPicture;
  DateTime createdAt;
  DateTime updatedAt;

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        id: json["id"],
        feedTitle: json["feedTitle"],
        feedDesc: json["feedDesc"],
        feedCategory: json["feedCategory"],
        feedPicture: json["feedPicture"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "feedTitle": feedTitle,
        "feedDesc": feedDesc,
        "feedCategory": feedCategory,
        "feedPicture": feedPicture,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
