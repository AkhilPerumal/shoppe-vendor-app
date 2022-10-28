import 'package:carclenx_vendor_app/data/api/api_checker.dart';
import 'package:carclenx_vendor_app/data/model/response/notification_model.dart';
import 'package:carclenx_vendor_app/data/repository/notification_repo.dart';
import 'package:carclenx_vendor_app/helper/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({@required this.notificationRepo});

  bool isLoading = false;

  List<NotificationModel> _notificationList;
  List<NotificationModel> get notificationList => _notificationList;

  getNotificationList() async {
    isLoading = true;
    update();
    Response response = await notificationRepo.getNotificationList();
    if (response.statusCode == 200) {
      isLoading = false;
      update();
      _notificationList = [];
      response.body["resultData"].forEach((notification) {
        NotificationModel _notification =
            NotificationModel.fromJson(notification);
        _notificationList.add(_notification);
      });
      _notificationList.sort((a, b) {
        return DateConverter.isoStringToLocalDate(a.updatedAt.toIso8601String())
            .compareTo(DateConverter.isoStringToLocalDate(
                b.updatedAt.toIso8601String()));
      });
      Iterable iterable = _notificationList.reversed;
      _notificationList = iterable.toList();
    } else {
      isLoading = false;
      update();
      ApiChecker.checkApi(response);
    }
    update();
  }

  void saveSeenNotificationCount(int count) {
    notificationRepo.saveSeenNotificationCount(count);
  }

  int getSeenNotificationCount() {
    return notificationRepo.getSeenNotificationCount();
  }
}
