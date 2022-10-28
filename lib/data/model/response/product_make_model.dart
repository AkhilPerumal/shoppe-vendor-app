class ProductMake {
  ProductMake({
    this.id,
    this.name,
    this.images,
    this.thumbnail,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.thumbUrl,
    this.imageUrl,
  });

  String id;
  String name;
  List<String> images;
  List<String> thumbnail;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<String> thumbUrl;
  List<String> imageUrl;

  factory ProductMake.fromJson(Map<String, dynamic> json) => ProductMake(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"] == null
            ? null
            : List<String>.from(json["thumbnail"].map((x) => x)),
        isActive: json["isActive"] == null ? null : json["isActive"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        thumbUrl: json["thumbURL"] == null
            ? null
            : List<String>.from(json["thumbURL"].map((x) => x)),
        imageUrl: json["imageURL"] == null
            ? null
            : List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail == null
            ? null
            : List<dynamic>.from(thumbnail.map((x) => x)),
        "isActive": isActive == null ? null : isActive,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
        "thumbURL": thumbUrl == null
            ? null
            : List<dynamic>.from(thumbUrl.map((x) => x)),
        "imageURL": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl.map((x) => x)),
      };
}
