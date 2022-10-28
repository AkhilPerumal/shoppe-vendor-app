import 'package:carclenx_vendor_app/data/model/response/service_count_details_model.dart';
import 'package:carclenx_vendor_app/data/model/response/shoppe_count_detail_model.dart';

class AllServiceWorkDetails {
  AllServiceWorkDetails({
    this.mechanical,
    this.quickhelp,
    this.shoppe,
    this.carspa,
  });

  ServiceCountDetailsModel mechanical;
  ServiceCountDetailsModel quickhelp;
  ShoppeCountDetailModel shoppe;
  ServiceCountDetailsModel carspa;

  factory AllServiceWorkDetails.fromJson(Map<String, dynamic> json) =>
      AllServiceWorkDetails(
        mechanical: json["mechanical"] == null
            ? null
            : ServiceCountDetailsModel.fromJson(json["mechanical"]),
        quickhelp: json["quickhelp"] == null
            ? null
            : ServiceCountDetailsModel.fromJson(json["quickhelp"]),
        shoppe: json["shoppe"] == null
            ? null
            : ShoppeCountDetailModel.fromJson(json["shoppe"]),
        carspa: json["carspa"] == null
            ? null
            : ServiceCountDetailsModel.fromJson(json["carspa"]),
      );

  Map<String, dynamic> toJson() => {
        "mechanical": mechanical == null ? null : mechanical.toJson(),
        "quickhelp": quickhelp == null ? null : quickhelp.toJson(),
        "shoppe": shoppe == null ? null : shoppe.toJson(),
        "carspa": carspa == null ? null : carspa.toJson(),
      };
}
