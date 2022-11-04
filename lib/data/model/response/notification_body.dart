import 'package:carclenx_vendor_app/helper/enums.dart';

class NotificationBody {
  NotificationType notificationType;
  String orderDocId;
  String orderId;
  String serviceName;
  CategoryType serviceType;
  String happyCode;
  String productName;
  String ServiceTypeString;
  String notificationTypeString;

  NotificationBody(
      {this.notificationType,
      this.orderId,
      this.orderDocId,
      this.serviceName,
      this.serviceType,
      this.happyCode,
      this.productName});

  NotificationBody.fromJson(Map<String, dynamic> json) {
    notificationType = convertToEnum(json['eventType']);
    orderId = json['orderId'] != null ? json['orderId'] : "";
    orderDocId = json['_id'] != null ? json['_id'] : "";
    serviceName = json['serviceName'] != null ? json['serviceName'] : "";
    serviceType = convertCategoryToEnum(json['assetType']);
    happyCode = json['happyCode'] != null ? json['happyCode'] : "";
    productName = json['productName'] != null ? json['productName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventType'] = this.notificationTypeString;
    data['orderId'] = this.orderId;
    data['_id'] = this.orderDocId;
    data['serviceName'] = this.serviceName;
    data['assetType'] = this.ServiceTypeString;
    data['happyCode'] = this.happyCode;
    data['productName'] = this.productName;
    return data;
  }

  NotificationType convertToEnum(String enumString) {
    notificationTypeString = enumString;
    if (enumString == "happy-code-generated") {
      return NotificationType.happyCode;
    } else if (enumString == 'order-in-progress' ||
        enumString == 'order-placed' ||
        enumString == 'order-completed' ||
        enumString == 'order-cancelled' ||
        enumString == 'order-rejected' ||
        enumString == 'order-confirmed' ||
        enumString == 'order-dispatched') {
      return NotificationType.order;
    }
    return NotificationType.general;
  }

  CategoryType convertCategoryToEnum(String enumString) {
    ServiceTypeString = enumString;
    if (enumString == 'Carspa') {
      return CategoryType.CAR_SPA;
    } else if (enumString == 'Mechanical') {
      return CategoryType.CAR_MECHANIC;
    } else if (enumString == 'Quickhelp') {
      return CategoryType.QUICK_HELP;
    } else {
      return CategoryType.CAR_SHOPPE;
    }
  }
}
