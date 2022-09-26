import 'package:carclenx_vendor_app/data/model/response/add_ons_model.dart';
import 'package:carclenx_vendor_app/data/model/response/address_model.dart';
import 'package:carclenx_vendor_app/data/model/response/service_model.dart';

class ServiceOrderListModel {
  String status;
  String message;
  List<OrderModel> resultData;

  ServiceOrderListModel({this.status, this.message, this.resultData});

  ServiceOrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['resultData'] != null) {
      resultData = <OrderModel>[];
      json['resultData'].forEach((v) {
        resultData.add(new OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.resultData != null) {
      data['resultData'] = this.resultData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderModel {
  String sId;
  String orderId;
  String customerId;
  String franchiseId;
  ServiceModel serviceId;
  String timeSlot;
  int price;
  String mode;
  String status;
  AddressModel address;
  List<AddOnsModel> addOn;
  String date;
  int discountAmount;
  int grandTotal;
  String paymentStatus;
  String workerId;
  String createdAt;
  String updatedAt;
  int iV;

  OrderModel(
      {this.sId,
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
      this.createdAt,
      this.updatedAt,
      this.iV});

  OrderModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['orderId'];
    customerId = json['customerId'];
    franchiseId = json['franchiseId'];
    serviceId = json['serviceId'] != null
        ? new ServiceModel.fromJson(json['serviceId'])
        : null;
    timeSlot = json['timeSlot'];
    price = json['price'];
    mode = json['mode'];
    status = json['status'];
    address = json['address'] != null
        ? new AddressModel.fromJson(json['address'])
        : null;
    if (json['addOn'] != null) {
      addOn = <AddOnsModel>[];
      json['addOn'].forEach((v) {
        addOn.add(AddOnsModel.fromJson(v));
      });
    }
    date = json['date'];
    discountAmount = json['discountAmount'];
    grandTotal = json['grandTotal'];
    paymentStatus = json['paymentStatus'];
    workerId = json['workerId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['orderId'] = this.orderId;
    data['customerId'] = this.customerId;
    data['franchiseId'] = this.franchiseId;
    if (this.serviceId != null) {
      data['serviceId'] = this.serviceId.toJson();
    }
    data['timeSlot'] = this.timeSlot;
    data['price'] = this.price;
    data['mode'] = this.mode;
    data['status'] = this.status;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.addOn != null) {
      data['addOn'] = this.addOn.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    data['discountAmount'] = this.discountAmount;
    data['grandTotal'] = this.grandTotal;
    data['paymentStatus'] = this.paymentStatus;
    data['workerId'] = this.workerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
