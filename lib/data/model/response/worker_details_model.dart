import 'package:carclenx_vendor_app/data/model/response/branch_model.dart';
import 'package:carclenx_vendor_app/data/model/response/location_model.dart';
import 'package:carclenx_vendor_app/data/model/response/ratings_model.dart';

class WorkerDetails {
  WorkerDetails({
    this.id,
    this.name,
    this.branchId,
    this.location,
    this.createdAt,
    this.ratings,
  });

  String id;
  String name;
  BranchId branchId;
  LocationModel location;
  DateTime createdAt;
  RatingsModel ratings;

  factory WorkerDetails.fromJson(Map<String, dynamic> json) => WorkerDetails(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        branchId: json["branchId"] == null
            ? null
            : BranchId.fromJson(json["branchId"]),
        location: json["location"] == null
            ? null
            : LocationModel.fromJson(json["location"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        ratings: json["ratings"] == null
            ? null
            : RatingsModel.fromJson(json["ratings"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "branchId": branchId == null ? null : branchId.toJson(),
        "location": location == null ? null : location.toJson(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "ratings": ratings == null ? null : ratings.toJson(),
      };
}
