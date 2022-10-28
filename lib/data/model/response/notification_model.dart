// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.id,
    this.userId,
    this.read,
    this.title,
    this.description,
    this.images,
    this.assetType,
    this.orderId,
    this.orderDocId,
    this.userType,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.thumbUrl,
    this.imageUrl,
  });

  String id;
  String userId;
  bool read;
  String title;
  String description;
  List<String> images;
  String assetType;
  String orderId;
  String orderDocId;
  String userType;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<dynamic> thumbUrl;
  List<String> imageUrl;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["_id"] == null ? null : json["_id"],
        userId: json["userId"] == null ? null : json["userId"],
        read: json["read"] == null ? null : json["read"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        assetType: json["assetType"] == null ? null : json["assetType"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        orderDocId: json["orderDocId"] == null ? null : json["orderDocId"],
        userType: json["userType"] == null ? null : json["userType"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        thumbUrl: json["thumbURL"] == null
            ? null
            : List<dynamic>.from(json["thumbURL"].map((x) => x)),
        imageUrl: json["imageURL"] == null
            ? null
            : List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "read": read == null ? null : read,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
        "assetType": assetType == null ? null : assetType,
        "orderId": orderId == null ? null : orderId,
        "orderDocId": orderDocId == null ? null : orderDocId,
        "userType": userType == null ? null : userType,
        "date": date == null ? null : date.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "thumbURL": thumbUrl == null
            ? null
            : List<dynamic>.from(thumbUrl.map((x) => x)),
        "imageURL": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl.map((x) => x)),
      };
}
