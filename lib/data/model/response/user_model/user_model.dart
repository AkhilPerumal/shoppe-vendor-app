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
  OrderCount orderCount;
  int todaysOrderCount;
  int thisWeekOrderCount;
  double cashInHands;
  Earnings earnings;
  double balance;
  double todaysEarning;
  double thisWeekEarning;
  double thisMonthEarning;

  bool isActive;
  List<Role> role;
  List<String> provides;

  UserModel({
    this.id,
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
    this.orderCount,
    this.todaysOrderCount = 0,
    this.thisWeekOrderCount = 0,
    this.cashInHands = 0,
    this.ratingCount = 0,
    this.earnings,
    this.balance = 0,
    this.todaysEarning = 0,
    this.thisWeekEarning = 0,
    this.thisMonthEarning = 0,
    this.isActive,
    this.role,
    this.provides,
  });

  setEarnings(Earnings earnings) {
    this.earnings = earnings;
  }

  setOrderCount(OrderCount orderCount) {
    this.orderCount = orderCount;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'] as String,
        phone: json['phone'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
        userToken: json['userToken'] as String,
        isActive: json['isActive'] as bool,
        role: (json['role'] as List<dynamic>)
            ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        provides: json['provides'].cast<String>(),
      );

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

class Earnings {
  int today_earning;
  int week_earning;
  int month_earning;
  int total_earned;
  Earnings(
      {this.today_earning = 0,
      this.week_earning = 0,
      this.month_earning = 0,
      this.total_earned = 0});
}

class OrderCount {
  int mechanical_todays_order_count;
  int mechanical_weekly_order_count;

  int carspa_todays_order_count;
  int carspa_weekly_order_count;

  int quickhelp_todays_order_count;
  int quickhelp_weekly_order_count;

  int mechanical_new_count;
  int mechanical_active_count;
  int mechanical_completed_count;
  int mechanical_cancelled_count;

  int carspa_new_count;
  int carspa_active_count;
  int carspa_completed_count;
  int carspa_cancelled_count;

  int quickhelp_new_count;
  int quickhelp_active_count;
  int quickhelp_completed_count;
  int quickhelp_cancelled_count;

  OrderCount(
      {this.carspa_todays_order_count = 0,
      this.carspa_weekly_order_count = 0,
      this.mechanical_todays_order_count = 0,
      this.mechanical_weekly_order_count = 0,
      this.quickhelp_todays_order_count = 0,
      this.quickhelp_weekly_order_count = 0,
      this.mechanical_new_count = 0,
      this.mechanical_active_count = 0,
      this.mechanical_completed_count = 0,
      this.mechanical_cancelled_count = 0,
      this.carspa_new_count = 0,
      this.carspa_active_count = 0,
      this.carspa_completed_count = 0,
      this.carspa_cancelled_count = 0,
      this.quickhelp_new_count = 0,
      this.quickhelp_active_count = 0,
      this.quickhelp_completed_count = 0,
      this.quickhelp_cancelled_count = 0});
}
