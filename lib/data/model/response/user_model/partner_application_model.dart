class PartnerApplicationId {
  PartnerApplicationId({
    this.id,
    this.phone,
    this.v,
    this.availability,
    this.district,
    this.email,
    this.experience,
    this.images,
    this.name,
    this.place,
    this.state,
    this.status,
    this.statusUpdates,
    this.thumbnail,
    this.username,
    this.thumbUrl,
    this.imageUrl,
  });

  String id;
  String phone;
  int v;
  String availability;
  String district;
  String email;
  Experience experience;
  List<String> images;
  String name;
  String place;
  String state;
  String status;
  List<dynamic> statusUpdates;
  List<String> thumbnail;
  String username;
  List<dynamic> thumbUrl;
  List<String> imageUrl;

  factory PartnerApplicationId.fromJson(Map<String, dynamic> json) =>
      PartnerApplicationId(
        id: json["_id"] == null ? null : json["_id"],
        phone: json["phone"] == null ? null : json["phone"],
        v: json["__v"] == null ? null : json["__v"],
        availability:
            json["availability"] == null ? null : json["availability"],
        district: json["district"] == null ? null : json["district"],
        email: json["email"] == null ? null : json["email"],
        experience: json["experience"] == null
            ? null
            : Experience.fromJson(json["experience"]),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        place: json["place"] == null ? null : json["place"],
        state: json["state"] == null ? null : json["state"],
        status: json["status"] == null ? null : json["status"],
        statusUpdates: json["status_updates"] == null
            ? null
            : List<dynamic>.from(json["status_updates"].map((x) => x)),
        thumbnail: json["thumbnail"] == null
            ? null
            : List<String>.from(json["thumbnail"].map((x) => x)),
        username: json["username"] == null ? null : json["username"],
        thumbUrl: json["thumbURL"] == null
            ? null
            : List<dynamic>.from(json["thumbURL"].map((x) => x)),
        imageUrl: json["imageURL"] == null
            ? null
            : List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "phone": phone == null ? null : phone,
        "__v": v == null ? null : v,
        "availability": availability == null ? null : availability,
        "district": district == null ? null : district,
        "email": email == null ? null : email,
        "experience": experience == null ? null : experience.toJson(),
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
        "name": name == null ? null : name,
        "place": place == null ? null : place,
        "state": state == null ? null : state,
        "status": status == null ? null : status,
        "status_updates": statusUpdates == null
            ? null
            : List<dynamic>.from(statusUpdates.map((x) => x)),
        "thumbnail": thumbnail == null
            ? null
            : List<dynamic>.from(thumbnail.map((x) => x)),
        "username": username == null ? null : username,
        "thumbURL": thumbUrl == null
            ? null
            : List<dynamic>.from(thumbUrl.map((x) => x)),
        "imageURL": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl.map((x) => x)),
      };
}

class Experience {
  Experience({
    this.total,
    this.carspa,
    this.mechanical,
    this.quickhelp,
    this.shoppe,
  });

  int total;
  int carspa;
  int mechanical;
  int quickhelp;
  int shoppe;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        total: json["total"] == null ? null : json["total"],
        carspa: json["carspa"] == null ? null : json["carspa"],
        mechanical: json["mechanical"] == null ? null : json["mechanical"],
        quickhelp: json["quickhelp"] == null ? null : json["quickhelp"],
        shoppe: json["shoppe"] == null ? null : json["shoppe"],
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "carspa": carspa == null ? null : carspa,
        "mechanical": mechanical == null ? null : mechanical,
        "quickhelp": quickhelp == null ? null : quickhelp,
        "shoppe": shoppe == null ? null : shoppe,
      };
}
