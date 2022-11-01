import 'package:carclenx_vendor_app/helper/enums.dart';

class NotificationPayloadModel {
  NotificationPayloadModel({
    this.data,
  });

  Payload data;

  factory NotificationPayloadModel.fromJson(Map<String, dynamic> json) =>
      NotificationPayloadModel(
        data: json["data"] == null ? null : Payload.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
      };
}

class Payload {
  Payload({
    this.date,
    this.orderId,
    this.id,
    this.eventType,
    this.productName,
    this.customer,
    this.assetType,
  });

  String date;
  String orderId;
  String id;
  String eventType;
  String productName;
  String customer;
  CategoryType assetType;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        date: json["date"] == null ? null : json["date"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        id: json["_id"] == null ? null : json["_id"],
        eventType: json["eventType"] == null ? null : json["eventType"],
        productName: json["productName"] == null ? null : json["productName"],
        customer: json["customer"] == null ? null : json["customer"],
        assetType: json["assetType"] == null
            ? null
            : EnumConverter.getNotificationEnum(json["assetType"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "orderId": orderId == null ? null : orderId,
        "_id": id == null ? null : id,
        "eventType": eventType == null ? null : eventType,
        "productName": productName == null ? null : productName,
        "customer": customer == null ? null : customer,
        "assetType": assetType == null
            ? null
            : EnumConverter.getNotificationString(assetType),
      };
}
