class AllNotificationList {
  AllNotificationList({
    this.status,
    this.message,
    this.resultData,
  });

  String status;
  String message;
  List<NotificationModel> resultData;

  factory AllNotificationList.fromJson(Map<String, dynamic> json) =>
      AllNotificationList(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        resultData: json["resultData"] == null
            ? null
            : List<NotificationModel>.from(
                json["resultData"].map((x) => NotificationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "resultData": resultData == null
            ? null
            : List<dynamic>.from(resultData.map((x) => x.toJson())),
      };
}

class NotificationModel {
  NotificationModel({
    this.id,
    this.orderDocId,
    this.v,
    this.assetType,
    this.createdAt,
    this.date,
    this.description,
    this.images,
    this.orderId,
    this.read,
    this.title,
    this.updatedAt,
    this.userId,
    this.userType,
    this.thumbUrl,
    this.imageUrl,
  });

  String id;
  String orderDocId;
  int v;
  String assetType;
  DateTime createdAt;
  DateTime date;
  String description;
  List<String> images;
  String orderId;
  bool read;
  String title;
  DateTime updatedAt;
  String userId;
  String userType;
  List<dynamic> thumbUrl;
  List<String> imageUrl;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["_id"] == null ? null : json["_id"],
        orderDocId: json["orderDocId"] == null ? null : json["orderDocId"],
        v: json["__v"] == null ? null : json["__v"],
        assetType: json["assetType"] == null ? null : json["assetType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"] == null ? null : json["description"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        orderId: json["orderId"] == null ? null : json["orderId"],
        read: json["read"] == null ? null : json["read"],
        title: json["title"] == null ? null : json["title"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userId: json["userId"] == null ? null : json["userId"],
        userType: json["userType"] == null ? null : json["userType"],
        thumbUrl: json["thumbURL"] == null
            ? null
            : List<dynamic>.from(json["thumbURL"].map((x) => x)),
        imageUrl: json["imageURL"] == null
            ? null
            : List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "orderDocId": orderDocId == null ? null : orderDocId,
        "__v": v == null ? null : v,
        "assetType": assetType == null ? null : assetType,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "date": date == null ? null : date.toIso8601String(),
        "description": description == null ? null : description,
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
        "orderId": orderId == null ? null : orderId,
        "read": read == null ? null : read,
        "title": title == null ? null : title,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "userId": userId == null ? null : userId,
        "userType": userType == null ? null : userType,
        "thumbURL": thumbUrl == null
            ? null
            : List<dynamic>.from(thumbUrl.map((x) => x)),
        "imageURL": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl.map((x) => x)),
      };
}
