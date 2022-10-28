class RatingsModel {
  RatingsModel({
    this.oneStar,
    this.twoStar,
    this.threeStar,
    this.fourStar,
    this.fiveStar,
    this.average,
  });

  StarCount oneStar;
  StarCount twoStar;
  StarCount threeStar;
  StarCount fourStar;
  StarCount fiveStar;
  int average;

  factory RatingsModel.fromJson(Map<String, dynamic> json) => RatingsModel(
        oneStar: json["1"] == null ? null : StarCount.fromJson(json["1"]),
        twoStar: json["2"] == null ? null : StarCount.fromJson(json["2"]),
        threeStar: json["3"] == null ? null : StarCount.fromJson(json["3"]),
        fourStar: json["4"] == null ? null : StarCount.fromJson(json["4"]),
        fiveStar: json["5"] == null ? null : StarCount.fromJson(json["5"]),
        average: json["average"] == null ? null : json["average"],
      );

  Map<String, dynamic> toJson() => {
        "1": oneStar == null ? null : oneStar.toJson(),
        "2": twoStar == null ? null : twoStar.toJson(),
        "3": threeStar == null ? null : threeStar.toJson(),
        "4": fourStar == null ? null : fourStar.toJson(),
        "5": fiveStar == null ? null : fiveStar.toJson(),
        "average": average == null ? null : average,
      };
}

class StarCount {
  StarCount({
    this.count,
    this.feedbackIds,
  });

  int count;
  List<String> feedbackIds;

  factory StarCount.fromJson(Map<String, dynamic> json) => StarCount(
        count: json["count"] == null ? 0 : json["count"],
        feedbackIds: json["feedbackIds"] == null
            ? null
            : List<String>.from(json["feedbackIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? 0 : count,
        "feedbackIds": feedbackIds == null
            ? null
            : List<dynamic>.from(feedbackIds.map((x) => x)),
      };
}
