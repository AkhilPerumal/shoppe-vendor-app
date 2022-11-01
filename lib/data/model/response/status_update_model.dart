class StatusUpdate {
  StatusUpdate({
    this.status,
    this.date,
    this.comment,
    this.updatedBy,
  });

  String status;
  DateTime date;
  String comment;
  UpdatedBy updatedBy;

  factory StatusUpdate.fromJson(Map<String, dynamic> json) => StatusUpdate(
        status: json["status"] == null ? null : json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        comment: json["comment"] == null ? null : json["comment"],
        updatedBy: json["updatedBy"] == null
            ? null
            : UpdatedBy.fromJson(json["updatedBy"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "date": date == null ? null : date.toIso8601String(),
        "comment": comment == null ? null : comment,
        "updatedBy": updatedBy == null ? null : updatedBy.toJson(),
      };
}

class UpdatedBy {
  UpdatedBy({
    this.name,
    this.phone,
    this.userId,
    this.username,
    this.role,
  });

  String name;
  String phone;
  String userId;
  String username;
  String role;

  factory UpdatedBy.fromJson(Map<String, dynamic> json) => UpdatedBy(
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        userId: json["userId"] == null ? null : json["userId"],
        username: json["username"] == null ? null : json["username"],
        role: json["role"] == null ? null : json["role"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "userId": userId == null ? null : userId,
        "username": username == null ? null : username,
        "role": role == null ? null : role,
      };
}
