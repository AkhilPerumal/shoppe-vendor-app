class ServiceCountDetailsModel {
  ServiceCountDetailsModel({
    this.daily,
    this.weekly,
    this.monthly,
    this.total,
  });

  DailyWorkDetails daily;
  WeeklyWorkDetails weekly;
  MonthlyWorkDetails monthly;
  TotalWorkDetails total;

  factory ServiceCountDetailsModel.fromJson(Map<String, dynamic> json) =>
      ServiceCountDetailsModel(
        daily: json["daily"] == null
            ? null
            : DailyWorkDetails.fromJson(json["daily"]),
        weekly: json["weekly"] == null
            ? null
            : WeeklyWorkDetails.fromJson(json["weekly"]),
        monthly: json["monthly"] == null
            ? null
            : MonthlyWorkDetails.fromJson(json["monthly"]),
        total: json["total"] == null
            ? null
            : TotalWorkDetails.fromJson(json["total"]),
      );

  Map<String, dynamic> toJson() => {
        "daily": daily == null ? null : daily.toJson(),
        "weekly": weekly == null ? null : weekly.toJson(),
        "monthly": monthly == null ? null : monthly.toJson(),
        "total": total == null ? null : total.toJson(),
      };
}

class DailyWorkDetails {
  DailyWorkDetails({
    this.earning,
    this.newCount,
    this.activeCount,
  });

  DailyEarning earning;
  int newCount;
  int activeCount;

  factory DailyWorkDetails.fromJson(Map<String, dynamic> json) =>
      DailyWorkDetails(
        earning: json["earning"] == null
            ? null
            : DailyEarning.fromJson(json["earning"]),
        newCount: json["new_count"] == null ? null : json["new_count"],
        activeCount: json["active_count"] == null ? null : json["active_count"],
      );

  Map<String, dynamic> toJson() => {
        "earning": earning == null ? null : earning.toJson(),
        "new_count": newCount == null ? null : newCount,
        "active_count": activeCount == null ? null : activeCount,
      };
}

class DailyEarning {
  DailyEarning({
    this.all,
  });

  int all;

  factory DailyEarning.fromJson(Map<String, dynamic> json) => DailyEarning(
        all: json["all"] == null ? 0 : json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all == null ? 0 : all,
      };
}

class MonthlyWorkDetails {
  MonthlyWorkDetails({
    this.earning,
  });

  MonthlyEarning earning;

  factory MonthlyWorkDetails.fromJson(Map<String, dynamic> json) =>
      MonthlyWorkDetails(
        earning: json["earning"] == null
            ? null
            : MonthlyEarning.fromJson(json["earning"]),
      );

  Map<String, dynamic> toJson() => {
        "earning": earning == null ? null : earning.toJson(),
      };
}

class MonthlyEarning {
  MonthlyEarning({
    this.cod,
    this.online,
  });

  int cod;
  int online;

  factory MonthlyEarning.fromJson(Map<String, dynamic> json) => MonthlyEarning(
        cod: json["cod"] == null ? 0 : json["cod"],
        online: json["online"] == null ? 0 : json["online"],
      );

  Map<String, dynamic> toJson() => {
        "cod": cod == null ? 0 : cod,
        "online": online == null ? 0 : online,
      };
}

class TotalWorkDetails {
  TotalWorkDetails({
    this.earning,
    this.activeCount,
    this.acceptedCount,
    this.rejectedCount,
    this.cancelledCount,
    this.completedCount,
    this.reassignedCount,
    this.averageRating,
  });

  int earning;
  int activeCount;
  int acceptedCount;
  int rejectedCount;
  int cancelledCount;
  int completedCount;
  int reassignedCount;
  var averageRating;

  factory TotalWorkDetails.fromJson(Map<String, dynamic> json) =>
      TotalWorkDetails(
        earning: json["earning"] == null ? 0 : json["earning"],
        activeCount: json["active_count"] == null ? 0 : json["active_count"],
        acceptedCount:
            json["accepted_count"] == null ? 0 : json["accepted_count"],
        rejectedCount:
            json["rejected_count"] == null ? 0 : json["rejected_count"],
        cancelledCount:
            json["cancelled_count"] == null ? 0 : json["cancelled_count"],
        completedCount:
            json["completed_count"] == null ? 0 : json["completed_count"],
        reassignedCount:
            json["reassigned_count"] == null ? 0 : json["reassigned_count"],
        averageRating:
            json["average_rating"] != null ? json["average_rating"] : 0,
      );

  Map<String, dynamic> toJson() => {
        "earning": earning == null ? null : earning,
        "active_count": activeCount == null ? 0 : activeCount,
        "accepted_count": acceptedCount == null ? 0 : acceptedCount,
        "rejected_count": rejectedCount == null ? 0 : rejectedCount,
        "cancelled_count": cancelledCount == null ? 0 : cancelledCount,
        "completed_count": completedCount == null ? 0 : completedCount,
        "reassigned_count": reassignedCount == null ? 0 : reassignedCount,
        "average_rating": averageRating,
      };
}

class WeeklyWorkDetails {
  WeeklyWorkDetails({
    this.earning,
  });

  DailyEarning earning;

  factory WeeklyWorkDetails.fromJson(Map<String, dynamic> json) =>
      WeeklyWorkDetails(
        earning: json["earning"] == null
            ? null
            : DailyEarning.fromJson(json["earning"]),
      );

  Map<String, dynamic> toJson() => {
        "earning": earning == null ? null : earning.toJson(),
      };
}
