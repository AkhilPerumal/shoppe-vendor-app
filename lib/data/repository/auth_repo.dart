import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:carclenx_vendor_app/controller/auth_controller.dart';
import 'package:carclenx_vendor_app/data/model/body/record_location_body.dart';
import 'package:carclenx_vendor_app/data/model/body/sign_up_body_model.dart';
import 'package:carclenx_vendor_app/data/model/response/user_model/role.dart';
import 'package:carclenx_vendor_app/data/model/response/user_model/user_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:carclenx_vendor_app/data/api/api_client.dart';
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
    return await apiClient.postData(uri: AppConstants.LOGIN_URI, body: {
      "username": name,
      "password": password,
    });
  }

  Future<Response> signUp(SignUpBody body) async {
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.LOCALIZATION_KEY: AppConstants.languages[0].languageCode,
    };
    return await apiClient.postData(
        uri: AppConstants.SIGNUP_URI, body: body.toJson(), headers: header);
  }

  Future<Response> uploadProductImageUpload(
      {Map<String, String> body, List<MultipartBody> images}) {
    return apiClient.postMultipartData(
        uri: AppConstants.UPLOAD_REG_DOC_IMAGE,
        body: body,
        multipartBody: images);
  }

  Future<Response> uploadRegImageUpload(
      {Map<String, String> body, List<MultipartBody> images}) {
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.LOCALIZATION_KEY: AppConstants.languages[0].languageCode,
    };
    return apiClient.postMultipartData(
        uri: AppConstants.UPLOAD_REG_DOC_IMAGE,
        body: body,
        // headers: header,
        multipartBody: images);
  }

  Future<Response> getProfileInfo({String userID}) async {
    return await apiClient.getData(uri: AppConstants.PROFILE_URI + userID);
  }

  Future<Response> recordLocation(RecordLocationBody recordLocationBody) {
    recordLocationBody.token = getUserToken();
    return apiClient.postData(
        uri: AppConstants.RECORD_LOCATION_URI,
        body: recordLocationBody.toJson());
  }

  Future<Response> validateUserName(String userName) async {
    String userNameBody =
        userName != null || userName != '' ? 'username=' + userName : '';
    return await apiClient.getData(
        uri: '/partner/partner-registration/validate-fields?' + userNameBody,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          AppConstants.LOCALIZATION_KEY: AppConstants.languages[0].languageCode
        });
  }

  Future<http.StreamedResponse> updateProfile(
      UserModel userInfoModel, XFile data, String token) async {
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
      'nname': userInfoModel.name,
      'email': userInfoModel.email,
      'token': getUserToken()
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<Response> changePassword(
      UserModel userInfoModel, String password) async {
    return await apiClient
        .postData(uri: AppConstants.UPDATE_PROFILE_URI, body: {
      '_method': 'put',
      'name': userInfoModel.name,
      'email': userInfoModel.email,
      'password': password,
      'token': getUserToken()
    });
  }

  Future<Response> updateActiveStatus() async {
    return await apiClient.postData(
        uri: AppConstants.ACTIVE_STATUS_URI, body: {'token': getUserToken()});
  }

  Future<Response> updateToken() async {
    String _deviceToken;
    var deviceId = '';
    var device = '';
    var deviceType = '';
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
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
      var data = await deviceInfoPlugin.iosInfo;
      device = data.name;
      deviceId = data.identifierForVendor;
      deviceType = 'Ios';
    } else {
      _deviceToken = await _saveDeviceToken();
      AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
      device = build.model;
      deviceId = build.id;
      deviceType = 'Android';
    }
    if (!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      // FirebaseMessaging.instance.subscribeToTopic(
      //     sharedPreferences.getString(AppConstants.ZONE_TOPIC));
    }
    print(Get.find<AuthController>().userModel.role[0].name);
    return await apiClient.postData(uri: AppConstants.TOKEN_URI, body: {
      "token": _deviceToken,
      "deviceId": deviceId,
      "device": device,
      "deviceType": deviceType,
      "userType": Get.find<AuthController>().userModel.role.length > 1
          ? 'partner'
          : Get.find<AuthController>().userModel.role[0].name == 'franchise'
              ? 'worker'
              : Get.find<AuthController>().userModel.role[0].name,
    });
  }

  Future<Response> getWorkerWorkDetails() {
    return apiClient.getData(uri: AppConstants.WORKER_WORK_DETAILS);
  }

  Future<String> _saveDeviceToken() async {
    String _deviceToken = '';

    _deviceToken = await FirebaseMessaging.instance.getToken();

    if (_deviceToken != null) {
      print('--------Firebase messaging Token---------- ' + _deviceToken);
    }
    return _deviceToken;
  }

  Future<Response> forgetPassword(String phone) async {
    return await apiClient.postData(
        uri: AppConstants.FORGET_PASSWORD_URI, body: {"phone": phone});
  }

  Future<Response> verifyToken(String phone, String token) async {
    return await apiClient.postData(
        uri: AppConstants.VERIFY_TOKEN_URI,
        body: {"phone": phone, "reset_token": token});
  }

  Future<Response> resetPassword(String resetToken, String phone,
      String password, String confirmPassword) async {
    return await apiClient.postData(
      uri: AppConstants.RESET_PASSWORD_URI,
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
    // if (!GetPlatform.isWeb) {
    //   await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    //   FirebaseMessaging.instance.unsubscribeFromTopic(
    //       sharedPreferences.getString(AppConstants.ZONE_TOPIC));
    //   apiClient.postData(
    //       uri: AppConstants.TOKEN_URI,
    //       body: {"_method": "put", "token": getUserToken(), "fcm_token": '@'});
    // }
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.setStringList(AppConstants.IGNORE_LIST, []);
    await sharedPreferences.remove(AppConstants.USER_ADDRESS);
    sharedPreferences.remove(AppConstants.IS_ACTIVE);
    sharedPreferences.remove(AppConstants.USER_NAME);
    sharedPreferences.remove(AppConstants.USER_NUMBER);
    sharedPreferences.remove(AppConstants.USER_ID);
    sharedPreferences.remove(AppConstants.USER_EMAIL);
    sharedPreferences.remove(AppConstants.PROVIDES);
    sharedPreferences.remove(AppConstants.ROLES);
    apiClient.updateHeader(null, null);
    return true;
  }

  Future<void> saveUserNameAndPassword(String name, String password) async {
    try {
      await sharedPreferences.setString(
          AppConstants.LOGIN_USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.LOGIN_USER_NAME, name);
    } catch (e) {
      throw e;
    }
  }

  setUserDetails(UserModel userModel) {
    sharedPreferences.setBool(AppConstants.IS_ACTIVE, userModel.isActive);
    sharedPreferences.setString(AppConstants.USER_ID, userModel.id);
    sharedPreferences.setString(AppConstants.USER_NAME, userModel.name);
    sharedPreferences.setString(AppConstants.USER_NUMBER, userModel.phone);
    sharedPreferences.setString(AppConstants.USER_EMAIL, userModel.email);
    sharedPreferences.setString(
        AppConstants.PROVIDES,
        userModel.provides != null && userModel.provides.length >= 0
            ? userModel.provides.join(',')
            : '');
    sharedPreferences.setString(
        AppConstants.ROLES,
        userModel.role.length != 1
            ? userModel.role.map((e) => e.name).toList().join(',')
            : userModel.role[0].name);
  }

  getUserDetails() {
    UserModel userModel = UserModel();
    userModel.isActive = sharedPreferences.get(AppConstants.IS_ACTIVE);
    userModel.id = sharedPreferences.get(AppConstants.USER_ID);
    userModel.name = sharedPreferences.get(AppConstants.USER_NAME);
    userModel.phone = sharedPreferences.get(AppConstants.USER_NUMBER);
    userModel.email = sharedPreferences.get(AppConstants.USER_EMAIL);
    userModel.provides =
        sharedPreferences.get(AppConstants.PROVIDES).toString().split(",");
    userModel.role = sharedPreferences
        .get(AppConstants.ROLES)
        .toString()
        .split(',')
        .map((e) => Role(name: e))
        .toList();
    return userModel;
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstants.USER_NAME) ?? "";
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.USER_ID) ?? "";
  }

  String getLoginUserName() {
    return sharedPreferences.getString(AppConstants.LOGIN_USER_NAME) ?? "";
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserCountryCode() {
    return sharedPreferences.getString(AppConstants.USER_COUNTRY_CODE) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.LOGIN_USER_PASSWORD) ?? "";
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
    await sharedPreferences.remove(AppConstants.LOGIN_USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.LOGIN_USER_NAME);
  }

  Future<Response> deleteDriver() async {
    return await apiClient
        .deleteData(AppConstants.DRIVER_REMOVE + getUserToken());
  }

  Future<Response> updateDocumentation(
      SignUpBody signUpBody, String documentationID) async {
    return await apiClient.putData(
        uri: AppConstants.UPDATE_DOCUMENTATION + documentationID,
        body: signUpBody.toJson());
  }
}
