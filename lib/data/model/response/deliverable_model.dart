class Deliverable {
  Deliverable({
    this.coordinates,
  });

  List<dynamic> coordinates;

  factory Deliverable.fromJson(Map<String, dynamic> json) => Deliverable(
        coordinates: json["coordinates"] == null
            ? null
            : List<dynamic>.from(json["coordinates"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
      };
}
