import 'role.dart';

class UserModel {
  String id;
  String phone;
  String name;
  String email;
  String username;
  String password;
  String userToken;
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
