import 'dart:convert';

import 'package:carclenx_vendor_app/data/api/api_client.dart';
import 'package:carclenx_vendor_app/data/model/body/record_location_body.dart';
import 'package:carclenx_vendor_app/data/model/body/update_status_body.dart';
import 'package:carclenx_vendor_app/data/model/response/ignore_model.dart';
import 'package:carclenx_vendor_app/helper/enums.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo extends GetxService {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getCurrentOrders() {
    return apiClient.getData(
        uri: AppConstants.CURRENT_ORDERS_URI + getUserToken());
  }

  Future<Response> getLatestOrders(
      {String status, String pageNo, CategoryType category}) {
    if (category == CategoryType.CAR_SHOPPE) {
      return apiClient.getData(
          uri: '/partner/' +
              EnumConverter.getCategoryString(category) +
              '/vendor?status=$status&page=$pageNo');
    } else {
      return apiClient.getData(
          uri: '/partner/' +
              EnumConverter.getCategoryString(category) +
              '/franchise?status=$status&page=$pageNo');
    }
  }

  Future<Response> recordLocation(RecordLocationBody recordLocationBody) {
    recordLocationBody.token = getUserToken();
    return apiClient.postData(
        uri: AppConstants.RECORD_LOCATION_URI,
        body: recordLocationBody.toJson());
  }

  Future<Response> orderStatusUpdate(
      {String orderID, String status, CategoryType category}) {
    if (category == CategoryType.CAR_SPA) {
      return apiClient.putData(
          uri: AppConstants.CARSPA_ACCEPT_ORDER_URI + orderID,
          body: {"status": status});
    }
    if (category == CategoryType.CAR_MECHANIC) {
      return apiClient.putData(
          uri: AppConstants.MECHANICS_ACCEPT_ORDER_URI + orderID,
          body: {"status": status});
    }
    if (category == CategoryType.QUICK_HELP) {
      return apiClient.putData(
          uri: AppConstants.QUICKHELP_ACCEPT_ORDER_URI + orderID,
          body: {"status": status});
    }
    if (category == CategoryType.CAR_SHOPPE) {
      return apiClient.putData(
          uri: AppConstants.SHOPPE_ACCEPT_ORDER_URI + orderID,
          body: {"status": status});
    }
    return null;
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

  Future<Response> generateHappyCode(
      {CategoryType category, Map<String, dynamic> body}) {
    return apiClient.postData(
        uri: '/partner/' +
            EnumConverter.getCategoryString(category) +
            '/create-happy-code',
        body: body);
  }

  Future<Response> verifyHappyCode(
      {@required Map<String, dynamic> body, CategoryType category}) {
    return apiClient.putData(
        uri: '/partner/' +
            EnumConverter.getCategoryString(category) +
            '/verify-happy-code',
        body: body);
  }
}
