// To parse this JSON data, do
//
//     final completedServiceBody = completedServiceBodyFromJson(jsonString);

import 'dart:convert';

import 'package:carclenx_vendor_app/data/model/response/add_on_model.dart';

CompletedServiceBody completedServiceBodyFromJson(String str) =>
    CompletedServiceBody.fromJson(json.decode(str));

String completedServiceBodyToJson(CompletedServiceBody data) =>
    json.encode(data.toJson());

class CompletedServiceBody {
  CompletedServiceBody({
    this.orderId,
    this.completedReport,
  });

  String orderId;
  CompletedReport completedReport;

  factory CompletedServiceBody.fromJson(Map<String, dynamic> json) =>
      CompletedServiceBody(
        orderId: json["orderId"],
        completedReport: CompletedReport.fromJson(json["completedReport"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "completedReport": completedReport.toJson(),
      };
}

class CompletedReport {
  CompletedReport({
    this.serviceId,
    this.addOns,
  });

  String serviceId;
  List<AddOn> addOns;

  factory CompletedReport.fromJson(Map<String, dynamic> json) =>
      CompletedReport(
        serviceId: json["serviceId"],
        addOns: List<AddOn>.from(json["addOns"].map((x) => AddOn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "addOns": List<dynamic>.from(addOns.map((x) => x.toJson())),
      };
}
