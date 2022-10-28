import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/data/api/api_client.dart';
import 'package:carclenx_vendor_app/data/model/response/user_model/role.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  NotificationRepo(
      {@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getNotificationList() async {
    String userType;
    if (sharedPreferences
            .get(AppConstants.ROLES)
            .toString()
            .contains("franchise") &&
        sharedPreferences
            .get(AppConstants.ROLES)
            .toString()
            .contains("vendor")) {
      userType = "partner";
    } else {
      if (sharedPreferences
          .get(AppConstants.ROLES)
          .toString()
          .contains("franchise")) {
        userType = "franchise";
      }
      if (sharedPreferences
          .get(AppConstants.ROLES)
          .toString()
          .contains("vendor")) {
        userType = "vendor";
      }
    }

    return await apiClient.getData(
        uri: AppConstants.NOTIFICATION_URI + userType);
  }

  void saveSeenNotificationCount(int count) {
    sharedPreferences.setInt(AppConstants.NOTIFICATION_COUNT, count);
  }

  int getSeenNotificationCount() {
    return sharedPreferences.getInt(AppConstants.NOTIFICATION_COUNT);
  }
}
