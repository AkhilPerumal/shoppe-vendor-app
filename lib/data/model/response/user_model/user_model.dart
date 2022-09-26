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
  int orderCount;
  int todaysOrderCount;
  int thisWeekOrderCount;
  double cashInHands;
  int earnings;
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
    this.orderCount = 0,
    this.todaysOrderCount = 0,
    this.thisWeekOrderCount = 0,
    this.cashInHands = 0,
    this.ratingCount = 0,
    this.earnings = 0,
    this.balance = 0,
    this.todaysEarning = 0,
    this.thisWeekEarning = 0,
    this.thisMonthEarning = 0,
    this.isActive,
    this.role,
    this.provides,
  });

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
