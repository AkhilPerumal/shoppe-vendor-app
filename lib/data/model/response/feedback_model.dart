class FeedbackModel {
  FeedbackModel({
    this.id,
    this.orderId,
    this.v,
    this.createdAt,
    this.customerId,
    this.description,
    this.rating,
    this.updatedAt,
    this.workerId,
  });

  String id;
  String orderId;
  int v;
  DateTime createdAt;
  String customerId;
  String description;
  int rating;
  DateTime updatedAt;
  String workerId;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        id: json["_id"] == null ? null : json["_id"],
        orderId: json["orderId"] == null ? null : json["orderId"],
        v: json["__v"] == null ? null : json["__v"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        customerId: json["customerId"] == null ? null : json["customerId"],
        description: json["description"] == null ? null : json["description"],
        rating: json["rating"] == null ? null : json["rating"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        workerId: json["workerId"] == null ? null : json["workerId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "orderId": orderId == null ? null : orderId,
        "__v": v == null ? null : v,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "customerId": customerId == null ? null : customerId,
        "description": description == null ? null : description,
        "rating": rating == null ? null : rating,
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "workerId": workerId == null ? null : workerId,
      };
}
