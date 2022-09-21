import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:carclenx_vendor_app/data/model/body/record_location_body.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

import 'package:carclenx_vendor_app/data/api/api_client.dart';
import 'package:carclenx_vendor_app/data/model/response/profile_model.dart';
import 'package:carclenx_vendor_app/util/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> login(String name, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, body: {
      "username": name,
      "password": password,
      'loginType': "franchise"
    });
  }

  Future<Response> getProfileInfo({String userID}) async {
    return await apiClient.getData(uri: AppConstants.PROFILE_URI + userID);
  }

  Future<Response> recordLocation(RecordLocationBody recordLocationBody) {
    recordLocationBody.token = getUserToken();
    return apiClient.postData(AppConstants.RECORD_LOCATION_URI,
        body: recordLocationBody.toJson());
  }

  Future<http.StreamedResponse> updateProfile(
      ProfileModel userInfoModel, XFile data, String token) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${AppConstants.BASE_URL}${AppConstants.UPDATE_PROFILE_URI}'));
    request.headers.addAll(<String, String>{'Authorization': 'Bearer $token'});
    if (GetPlatform.isMobile && data != null) {
      File _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    } else if (GetPlatform.isWeb && data != null) {
      Uint8List _list = await data.readAsBytes();
      var part = http.MultipartFile(
          'image', data.readAsBytes().asStream(), _list.length,
          filename: basename(data.path),
          contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      '_method': 'put',
      'f_name': userInfoModel.fName,
      'l_name': userInfoModel.lName,
      'email': userInfoModel.email,
      'token': getUserToken()
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<Response> changePassword(
      ProfileModel userInfoModel, String password) async {
    return await apiClient.postData(AppConstants.UPDATE_PROFILE_URI, body: {
      '_method': 'put',
      'f_name': userInfoModel.fName,
      'l_name': userInfoModel.lName,
      'email': userInfoModel.email,
      'password': password,
      'token': getUserToken()
    });
  }

  Future<Response> updateActiveStatus() async {
    return await apiClient.postData(AppConstants.ACTIVE_STATUS_URI,
        body: {'token': getUserToken()});
  }

  Future<Response> updateToken() async {
    String _deviceToken;
    if (GetPlatform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
      }
    } else {
      _deviceToken = await _saveDeviceToken();
    }
    if (!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      // FirebaseMessaging.instance.subscribeToTopic(
      //     sharedPreferences.getString(AppConstants.ZONE_TOPIC));
    }
    return await apiClient.postData(AppConstants.TOKEN_URI, body: {
      "_method": "put",
      "token": getUserToken(),
      "fcm_token": _deviceToken
    });
  }

  Future<String> _saveDeviceToken() async {
    String _deviceToken = '';
    if (!GetPlatform.isWeb) {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }
    if (_deviceToken != null) {
      print('--------Device Token---------- ' + _deviceToken);
    }
    return _deviceToken;
  }

  Future<Response> forgetPassword(String phone) async {
    return await apiClient
        .postData(AppConstants.FORGET_PASSWORD_URI, body: {"phone": phone});
  }

  Future<Response> verifyToken(String phone, String token) async {
    return await apiClient.postData(AppConstants.VERIFY_TOKEN_URI,
        body: {"phone": phone, "reset_token": token});
  }

  Future<Response> resetPassword(String resetToken, String phone,
      String password, String confirmPassword) async {
    return await apiClient.postData(
      AppConstants.RESET_PASSWORD_URI,
      body: {
        "_method": "put",
        "phone": phone,
        "reset_token": resetToken,
        "password": password,
        "confirm_password": confirmPassword
      },
    );
  }

  Future<bool> saveUserToken(String token, String zoneTopic) async {
    apiClient.token = token;
    apiClient.updateHeader(
        token, sharedPreferences.getString(AppConstants.LANGUAGE_CODE));
    // sharedPreferences.setString(AppConstants.ZONE_TOPIC, zoneTopic);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    if (!GetPlatform.isWeb) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
      FirebaseMessaging.instance.unsubscribeFromTopic(
          sharedPreferences.getString(AppConstants.ZONE_TOPIC));
      apiClient.postData(AppConstants.TOKEN_URI,
          body: {"_method": "put", "token": getUserToken(), "fcm_token": '@'});
    }
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.setStringList(AppConstants.IGNORE_LIST, []);
    await sharedPreferences.remove(AppConstants.USER_ADDRESS);
    apiClient.updateHeader(null, null);
    return true;
  }

  Future<void> saveUserNameAndPassword(String name, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NAME, name);
    } catch (e) {
      throw e;
    }
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstants.USER_NAME) ?? "";
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserCountryCode() {
    return sharedPreferences.getString(AppConstants.USER_COUNTRY_CODE) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }

  void setNotificationActive(bool isActive) {
    if (isActive) {
      updateToken();
    } else {
      if (!GetPlatform.isWeb) {
        FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
        FirebaseMessaging.instance.unsubscribeFromTopic(
            sharedPreferences.getString(AppConstants.ZONE_TOPIC));
      }
    }
    sharedPreferences.setBool(AppConstants.NOTIFICATION, isActive);
  }

  Future<bool> clearUserNameAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_NAME);
  }

  Future<Response> deleteDriver() async {
    return await apiClient
        .deleteData(AppConstants.DRIVER_REMOVE + getUserToken());
  }
}
