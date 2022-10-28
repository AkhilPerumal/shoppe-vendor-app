import 'package:carclenx_vendor_app/data/model/response/deliverable_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_category_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_model_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_sub_category_model.dart';
import 'package:carclenx_vendor_app/data/model/response/ratings_model.dart';

class ProductDetails {
  ProductDetails({
    this.id,
    this.name,
    this.userId,
    this.deliverable,
    this.price,
    this.modelId,
    this.categoryId,
    this.subCategoryId,
    this.images,
    this.thumbnail,
    this.description,
    this.quantity,
    this.offerPrice,
    this.sold,
    this.status,
    this.offerId,
    this.isActive,
    this.ratings,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.thumbUrl,
    this.imageUrl,
  });

  String id;
  String name;
  String userId;
  Deliverable deliverable;
  int price;
  List<ProductModel> modelId;
  ProductCategory categoryId;
  ProductSubCategory subCategoryId;
  List<dynamic> images;
  List<dynamic> thumbnail;
  String description;
  int quantity;
  int offerPrice;
  int sold;
  int status;
  dynamic offerId;
  bool isActive;
  RatingsModel ratings;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<dynamic> thumbUrl;
  List<dynamic> imageUrl;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        userId: json["user_id"] == null ? null : json["user_id"],
        deliverable: json["deliverable"] == null
            ? null
            : Deliverable.fromJson(json["deliverable"]),
        price: json["price"] == null ? null : json["price"],
        modelId: json["model_id"] == null
            ? null
            : List<ProductModel>.from(
                json["model_id"].map((x) => ProductModel.fromJson(x))),
        categoryId: json["category_id"] == null
            ? null
            : ProductCategory.fromJson(json["category_id"]),
        subCategoryId: json["sub_category_id"] == null
            ? null
            : ProductSubCategory.fromJson(json["sub_category_id"]),
        images: json["images"] == null
            ? null
            : List<dynamic>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"] == null
            ? null
            : List<dynamic>.from(json["thumbnail"].map((x) => x)),
        description: json["description"] == null ? null : json["description"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
        sold: json["sold"] == null ? null : json["sold"],
        status: json["status"] == null ? null : json["status"],
        offerId: json["offerId"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        ratings: json["ratings"] == null
            ? null
            : RatingsModel.fromJson(json["ratings"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        thumbUrl: json["thumbURL"] == null
            ? null
            : List<dynamic>.from(json["thumbURL"].map((x) => x)),
        imageUrl: json["imageURL"] == null
            ? null
            : List<dynamic>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "user_id": userId == null ? null : userId,
        "deliverable": deliverable == null ? null : deliverable.toJson(),
        "price": price == null ? null : price,
        "model_id":
            modelId == null ? null : List<dynamic>.from(modelId.map((x) => x)),
        "category_id": categoryId == null ? null : categoryId.toJson(),
        "sub_category_id":
            subCategoryId == null ? null : subCategoryId.toJson(),
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail == null
            ? null
            : List<dynamic>.from(thumbnail.map((x) => x)),
        "description": description == null ? null : description,
        "quantity": quantity == null ? null : quantity,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "sold": sold == null ? null : sold,
        "status": status == null ? null : status,
        "offerId": offerId,
        "isActive": isActive == null ? null : isActive,
        "ratings": ratings == null ? null : ratings.toJson(),
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
