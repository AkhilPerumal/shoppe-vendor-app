import 'package:carclenx_vendor_app/data/model/response/product_details_model.dart';

class ProductItemCount {
  ProductItemCount({
    this.type,
    this.productDetails,
    this.count,
  });

  String type;
  ProductDetails productDetails;
  int count;

  factory ProductItemCount.fromJson(Map<String, dynamic> json) =>
      ProductItemCount(
        type: json["type"] == null ? null : json["type"],
        productDetails: json["item_id"] == null
            ? null
            : ProductDetails.fromJson(json["item_id"]),
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "item_id": productDetails == null ? null : productDetails.toJson(),
        "count": count == null ? null : count,
      };
}
