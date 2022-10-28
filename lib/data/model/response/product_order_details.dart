import 'package:carclenx_vendor_app/data/model/response/address_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_item_count.dart';
import 'package:carclenx_vendor_app/data/model/response/user_model/user_model.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';

class ProductOrderDetails {
  ProductOrderDetails({
    this.id,
    this.user,
    this.orderDetails,
    this.orderId,
    this.vendor,
    this.total,
    this.paymentType,
    this.status,
    this.address,
    this.location,
    this.createdAt,
  });

  String id;
  UserModel user;
  ProductItemCount orderDetails;
  String orderId;
  String vendor;
  int total;
  String paymentType;
  OrderStatus status;
  AddressModel address;
  List<dynamic> location;
  DateTime createdAt;

  factory ProductOrderDetails.fromJson(Map<String, dynamic> json) =>
      ProductOrderDetails(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        orderDetails: json["item"] == null
            ? null
            : ProductItemCount.fromJson(json["item"]),
        orderId: json["order_id"] == null ? null : json["order_id"],
        vendor: json["vendor"] == null ? null : json["vendor"],
        total: json["total"] == null ? null : json["total"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        status: json["status"] == null
            ? null
            : EnumConverter.convertEnumFromStatus(json['status']),
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        location: json["location"] == null
            ? null
            : List<dynamic>.from(json["location"].map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user.toJson(),
        "item": orderDetails == null ? null : orderDetails.toJson(),
        "order_id": orderId == null ? null : orderId,
        "vendor": vendor == null ? null : vendor,
        "total": total == null ? null : total,
        "paymentType": paymentType == null ? null : paymentType,
        "status":
            status == null ? null : EnumConverter.convertEnumToStatus(status),
        "address": address == null ? null : address.toJson(),
        "location": location == null
            ? null
            : List<dynamic>.from(location.map((x) => x)),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
      };
}
