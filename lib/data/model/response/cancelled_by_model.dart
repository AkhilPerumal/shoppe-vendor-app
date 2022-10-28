class CancelledBy {
  CancelledBy({
    this.userId,
    this.name,
    this.phone,
    this.username,
    this.role,
  });

  String userId;
  String name;
  String phone;
  String username;
  String role;

  factory CancelledBy.fromJson(Map<String, dynamic> json) => CancelledBy(
        userId: json["userId"] == null ? null : json["userId"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        username: json["username"] == null ? null : json["username"],
        role: json["role"] == null ? null : json["role"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "username": username == null ? null : username,
        "role": role == null ? null : role,
      };
}
