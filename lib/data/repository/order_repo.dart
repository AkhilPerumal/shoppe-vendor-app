import 'dart:convert';

import 'package:carclenx_vendor_app/data/api/api_client.dart';
import 'package:carclenx_vendor_app/data/model/body/record_location_body.dart';
import 'package:carclenx_vendor_app/data/model/body/update_status_body.dart';
import 'package:carclenx_vendor_app/data/model/response/ignore_model.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getAllOrders() {
    return apiClient.getData(uri: AppConstants.ALL_ORDERS_URI + getUserToken());
  }

  Future<Response> getCompletedOrderList(int offset) async {
    return await apiClient.getData(
        uri:
            '${AppConstants.ALL_ORDERS_URI}?token=${getUserToken()}&offset=$offset&limit=10');
  }

  Future<Response> getCurrentOrders() {
    return apiClient.getData(
        uri: AppConstants.CURRENT_ORDERS_URI + getUserToken());
  }

  Future<Response> getLatestOrders(
      {String status, String pageNo, String category}) {
    if (category == 'car_spa'.tr) {
      return apiClient.getData(
          uri: '/carspa-order/franchise?status=$status&page=$pageNo');
    } else if (category == 'car_mechanical'.tr) {
      return apiClient.getData(
          uri: '/mechanical-order/franchise?status=$status&page=$pageNo');
    } else if (category == 'quick_help'.tr) {
      return apiClient.getData(
          uri: '/quickhelp-order/franchise?status=$status&page=$pageNo');
    } else {
      return apiClient.getData(
          uri: '/order/vendor?status=$status&page=$pageNo');
    }
  }

  Future<Response> recordLocation(RecordLocationBody recordLocationBody) {
    recordLocationBody.token = getUserToken();
    return apiClient.postData(AppConstants.RECORD_LOCATION_URI,
        body: recordLocationBody.toJson());
  }

  Future<Response> updateOrderStatus(UpdateStatusBody updateStatusBody) {
    updateStatusBody.token = getUserToken();
    return apiClient.postData(AppConstants.UPDATE_ORDER_STATUS_URI,
        body: updateStatusBody.toJson());
  }

  Future<Response> updatePaymentStatus(UpdateStatusBody updateStatusBody) {
    updateStatusBody.token = getUserToken();
    return apiClient.postData(AppConstants.UPDATE_PAYMENT_STATUS_URI,
        body: updateStatusBody.toJson());
  }

  Future<Response> getOrderDetails(String orderID) {
    return apiClient.getData(
        uri:
            '${AppConstants.ORDER_DETAILS_URI}${getUserToken()}&order_id=$orderID');
  }

  Future<Response> acceptOrder(int orderID) {
    return apiClient.postData(AppConstants.ACCEPT_ORDER_URI,
        body: {"_method": "put", 'token': getUserToken(), 'order_id': orderID});
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  void setIgnoreList(List<IgnoreModel> ignoreList) {
    List<String> _stringList = [];
    ignoreList.forEach((ignore) {
      _stringList.add(jsonEncode(ignore.toJson()));
    });
    sharedPreferences.setStringList(AppConstants.IGNORE_LIST, _stringList);
  }

  List<IgnoreModel> getIgnoreList() {
    List<IgnoreModel> _ignoreList = [];
    List<String> _stringList =
        sharedPreferences.getStringList(AppConstants.IGNORE_LIST) ?? [];
    _stringList.forEach((ignore) {
      _ignoreList.add(IgnoreModel.fromJson(jsonDecode(ignore)));
    });
    return _ignoreList;
  }

  Future<Response> getOrderWithId(String orderId) {
    return apiClient.getData(
        uri:
            '${AppConstants.CURRENT_ORDER_URI}${getUserToken()}&order_id=$orderId');
  }
}
