class BranchId {
  BranchId({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.images,
  });

  String id;
  String name;
  String address;
  int phone;
  List<dynamic> images;

  factory BranchId.fromJson(Map<String, dynamic> json) => BranchId(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        phone: json["phone"] == null ? null : json["phone"],
        images: json["images"] == null
            ? null
            : List<dynamic>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "phone": phone == null ? null : phone,
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
      };
}
