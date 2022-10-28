import 'package:carclenx_vendor_app/data/model/response/add_on_model.dart';
import 'package:carclenx_vendor_app/data/model/response/address_model.dart';
import 'package:carclenx_vendor_app/data/model/response/cancelled_by_model.dart';
import 'package:carclenx_vendor_app/data/model/response/complete_repport_model.dart';
import 'package:carclenx_vendor_app/data/model/response/feedback_model.dart';
import 'package:carclenx_vendor_app/data/model/response/service_model.dart';
import 'package:carclenx_vendor_app/data/model/response/worker_details_model.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';

class OrderModel {
  String id;
  String orderId;
  String customerId;
  CategoryType category;
  String franchiseId;
  ServiceModel serviceId;
  String timeSlot;
  int price;
  String mode;
  OrderStatus status;
  AddressModel address;
  List<AddOn> addOn;
  DateTime date;
  int discountAmount;
  int grandTotal;
  String paymentStatus;
  String workerId;
  CompletedReport completedReport;
  String happyCode;
  DateTime happyCodeCreatedDate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  WorkerDetails workerDetails;
  CancelledBy cancelledBy;
  FeedbackModel feedbackId;

  OrderModel({
    this.id,
    this.orderId,
    this.customerId,
    this.franchiseId,
    this.serviceId,
    this.timeSlot,
    this.price,
    this.mode,
    this.status,
    this.address,
    this.addOn,
    this.date,
    this.discountAmount,
    this.grandTotal,
    this.paymentStatus,
    this.workerId,
    this.completedReport,
    this.happyCode,
    this.happyCodeCreatedDate,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.workerDetails,
    this.cancelledBy,
    this.feedbackId,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"] == null ? null : json["_id"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        customerId: json["customerId"] == null ? null : json["customerId"],
        franchiseId: json["franchiseId"] == null ? null : json["franchiseId"],
        serviceId: json["serviceId"] == null
            ? null
            : ServiceModel.fromJson(json["serviceId"]),
        timeSlot: json["timeSlot"] == null ? null : json["timeSlot"],
        price: json["price"] == null ? null : json["price"],
        mode: json["mode"] == null ? null : json["mode"],
        status: EnumConverter.convertEnumFromStatus(json['status']),
        address: json["address"] == null
            ? null
            : AddressModel.fromJson(json["address"]),
        addOn: json["addOn"] == null
            ? null
            : List<AddOn>.from(json["addOn"].map((x) => AddOn.fromJson(x))),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        discountAmount:
            json["discountAmount"] == null ? null : json["discountAmount"],
        grandTotal: json["grandTotal"] == null ? null : json["grandTotal"],
        paymentStatus:
            json["paymentStatus"] == null ? null : json["paymentStatus"],
        workerId: json["workerId"] == null ? null : json["workerId"],
        completedReport: json["completedReport"] == null
            ? null
            : CompletedReport.fromJson(json["completedReport"]),
        happyCode: json["happyCode"] == null ? null : json["happyCode"],
        happyCodeCreatedDate: json["happyCodeCreatedDate"] == null
            ? null
            : DateTime.parse(json["happyCodeCreatedDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        workerDetails: json["workerDetails"] == null
            ? null
            : WorkerDetails.fromJson(json["workerDetails"]),
        cancelledBy: json["cancelledBy"] == null
            ? null
            : CancelledBy.fromJson(json["cancelledBy"]),
        feedbackId: json["feedbackId"] == null
            ? null
            : FeedbackModel.fromJson(json["feedbackId"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "orderId": orderId == null ? null : orderId,
        "customerId": customerId == null ? null : customerId,
        "franchiseId": franchiseId == null ? null : franchiseId,
        "serviceId": serviceId == null ? null : serviceId.toJson(),
        "timeSlot": timeSlot == null ? null : timeSlot,
        "price": price == null ? null : price,
        "mode": mode == null ? null : mode,
        "status":
            status == null ? null : EnumConverter.convertEnumToStatus(status),
        "address": address == null ? null : address.toJson(),
        "addOn": addOn == null
            ? null
            : List<dynamic>.from(addOn.map((x) => x.toJson())),
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "discountAmount": discountAmount == null ? null : discountAmount,
        "grandTotal": grandTotal == null ? null : grandTotal,
        "paymentStatus": paymentStatus == null ? null : paymentStatus,
        "workerId": workerId == null ? null : workerId,
        "completedReport":
            completedReport == null ? null : completedReport.toJson(),
        "happyCode": happyCode == null ? null : happyCode,
        "happyCodeCreatedDate": happyCodeCreatedDate == null
            ? null
            : happyCodeCreatedDate.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "workerDetails": workerDetails == null ? null : workerDetails.toJson(),
        "cancelledBy": cancelledBy == null ? null : cancelledBy.toJson(),
        "feedbackId": feedbackId == null ? null : feedbackId.toJson(),
      };
}
