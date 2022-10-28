import 'package:carclenx_vendor_app/data/model/response/add_on_model.dart';

class CompletedReport {
  CompletedReport({
    this.addOn,
    this.serviceId,
    this.grandTotal,
  });

  List<AddOn> addOn;
  String serviceId;
  int grandTotal;

  factory CompletedReport.fromJson(Map<String, dynamic> json) =>
      CompletedReport(
        addOn: json["addOn"] == null
            ? null
            : List<AddOn>.from(json["addOn"].map((x) => AddOn.fromJson(x))),
        serviceId: json["serviceId"] == null ? null : json["serviceId"],
        grandTotal: json["grandTotal"] == null ? null : json["grandTotal"],
      );

  Map<String, dynamic> toJson() => {
        "addOn": addOn == null
            ? null
            : List<dynamic>.from(addOn.map((x) => x.toJson())),
        "serviceId": serviceId == null ? null : serviceId,
        "grandTotal": grandTotal == null ? null : grandTotal,
      };
}
