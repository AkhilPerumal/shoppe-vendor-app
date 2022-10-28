class LocationModel {
  LocationModel({
    this.type,
    this.coordinates,
    this.id,
  });

  String type;
  List<double> coordinates;
  String id;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
        "_id": id == null ? null : id,
      };
}
