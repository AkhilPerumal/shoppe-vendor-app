import 'package:carclenx_vendor_app/data/model/response/all_service_work_details_model.dart';
import 'package:carclenx_vendor_app/data/model/response/status_update_model.dart';
import 'package:carclenx_vendor_app/data/model/response/user_model/partner_application_model.dart';
import 'package:carclenx_vendor_app/helper/date_converter.dart';

import 'role.dart';

class UserModel {
  String id;
  String phone;
  String name;
  String email;
  String username;
  String password;
  String userToken;
  String image;
  String fcmToken;
  double avgRating;
  int ratingCount;
  int memberSinceDays;
  AllServiceWorkDetails allServiceWorkDetails;
  PartnerApplicationId partnerApplicationId;
  int todaysOrderCount;
  int thisWeekOrderCount;
  double cashInHands;
  double balance;
  // double todaysEarning;
  // double thisWeekEarning;
  // double thisMonthEarning;
  List<StatusUpdate> statusUpdates;
  String status;
  bool isActive;
  List<Role> role;
  List<String> provides;
  bool isEnabledShoppe;
  bool isEnabledCarSpa;
  bool isEnabledMechanic;
  bool isEnabledQuickHelp;

  UserModel(
      {this.id,
      this.phone,
      this.name,
      this.email,
      this.username,
      this.password,
      this.userToken,
      this.image,
      this.fcmToken,
      this.avgRating = 0,
      this.memberSinceDays,
      this.allServiceWorkDetails,
      this.partnerApplicationId,
      this.todaysOrderCount = 0,
      this.thisWeekOrderCount = 0,
      this.cashInHands = 0,
      this.ratingCount = 0,
      this.balance = 0,
      // this.todaysEarning = 0,
      // this.thisWeekEarning = 0,
      // this.thisMonthEarning = 0,
      this.isActive = false,
      this.role,
      this.provides,
      this.status,
      this.statusUpdates,
      this.isEnabledCarSpa,
      this.isEnabledMechanic,
      this.isEnabledShoppe,
      this.isEnabledQuickHelp});

  setWorkerCounts(AllServiceWorkDetails allServiceWorkDetails) {
    this.allServiceWorkDetails = allServiceWorkDetails;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    phone = json['phone'] as String;
    name = json['name'] as String;
    email = json['email'] as String;
    username = json['username'] as String;
    password = json['password'] as String;
    userToken = json['userToken'] as String;
    isActive = json['isActive'] != null ? json['isActive'] : false;
    partnerApplicationId = json["partner_application_id"] == null
        ? null
        : PartnerApplicationId.fromJson(json["partner_application_id"]);
    status = json["status"] == null ? null : json["status"];
    statusUpdates = json["status_updates"] == null
        ? null
        : List<StatusUpdate>.from(
            json["status_updates"].map((x) => StatusUpdate.fromJson(x)));
    role = (json['role'] as List<dynamic>)
        ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
        ?.toList();
    provides = json['provides'] != null ? json['provides'].cast<String>() : [];
    isEnabledCarSpa =
        provides.length > 0 ? json['provides'].contains('Carspa') : false;
    isEnabledMechanic =
        provides.length > 0 ? provides.contains('Mechanical') : false;
    isEnabledQuickHelp =
        provides.length > 0 ? provides.contains('Quickhelp') : false;
    isEnabledShoppe = role.isNotEmpty
        ? role.where((element) => element.name == "vendor").length > 0
        : false;

    if (statusUpdates != null) {
      statusUpdates.sort((a, b) {
        return DateConverter.isoStringToLocalDate(a.date.toIso8601String())
            .compareTo(
                DateConverter.isoStringToLocalDate(b.date.toIso8601String()));
      });
      Iterable iterable = statusUpdates.reversed;
      statusUpdates = iterable.toList();
    }
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'phone': phone,
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'userToken': userToken,
        'isActive': isActive,
        'role': role?.map((e) => e.toJson())?.toList(),
        'provides': provides,
      };
}
