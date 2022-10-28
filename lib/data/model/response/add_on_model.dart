class AddOn {
  AddOn({
    this.name,
    this.price,
    this.id,
  });

  String name;
  int price;
  String id;
  bool isSelected = false;

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        id: json["_id"] == null ? "" : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "_id": id == null ? null : id,
      };
}
