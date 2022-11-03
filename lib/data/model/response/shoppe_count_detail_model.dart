import 'package:carclenx_vendor_app/data/model/response/service_count_details_model.dart';

class ShoppeCountDetailModel {
  ShoppeCountDetailModel({
    this.daily,
    this.weekly,
    this.monthly,
    this.total,
  });

  DailyWorkDetails daily;
  WeeklyWorkDetails weekly;
  MonthlyWorkDetails monthly;
  ShoppeTotal total;

  factory ShoppeCountDetailModel.fromJson(Map<String, dynamic> json) =>
      ShoppeCountDetailModel(
        daily: json["daily"] == null
            ? null
            : DailyWorkDetails.fromJson(json["daily"]),
        weekly: json["weekly"] == null
            ? null
            : WeeklyWorkDetails.fromJson(json["weekly"]),
        monthly: json["monthly"] == null
            ? null
            : MonthlyWorkDetails.fromJson(json["monthly"]),
        total:
            json["total"] == null ? null : ShoppeTotal.fromJson(json["total"]),
      );

  Map<String, dynamic> toJson() => {
        "daily": daily == null ? null : daily.toJson(),
        "weekly": weekly == null ? null : weekly.toJson(),
        "monthly": monthly == null ? null : monthly.toJson(),
        "total": total == null ? null : total.toJson(),
      };
}

class ShoppeTotal {
  ShoppeTotal({
    this.earning,
    this.processingCount,
    this.confirmedCount,
    this.dispatchedCount,
    this.cancelledCount,
    this.completedCount,
    this.averageRating,
  });

  int earning;
  int processingCount;
  int confirmedCount;
  int dispatchedCount;
  int cancelledCount;
  int completedCount;
  dynamic averageRating = 0;

  factory ShoppeTotal.fromJson(Map<String, dynamic> json) => ShoppeTotal(
        earning: json["earning"] == null ? null : json["earning"],
        processingCount:
            json["processing_count"] == null ? null : json["processing_count"],
        confirmedCount:
            json["confirmed_count"] == null ? null : json["confirmed_count"],
        dispatchedCount:
            json["dispatched_count"] == null ? null : json["dispatched_count"],
        cancelledCount:
            json["cancelled_count"] == null ? null : json["cancelled_count"],
        completedCount:
            json["completed_count"] == null ? null : json["completed_count"],
        averageRating:
            json["average_rating"] != null ? json["average_rating"] : 0,
      );

  Map<String, dynamic> toJson() => {
        "earning": earning == null ? null : earning,
        "processing_count": processingCount == null ? null : processingCount,
        "confirmed_count": confirmedCount == null ? null : confirmedCount,
        "dispatched_count": dispatchedCount == null ? null : dispatchedCount,
        "cancelled_count": cancelledCount == null ? null : cancelledCount,
        "completed_count": completedCount == null ? null : completedCount,
        "average_rating": averageRating,
      };
}
