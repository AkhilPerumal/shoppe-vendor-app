import 'package:carclenx_vendor_app/data/model/response/product_category_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_make_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_model_model.dart';
import 'package:carclenx_vendor_app/data/model/response/product_sub_category_model.dart';

class CreateProductCategoriesModel {
  CreateProductCategoriesModel({
    this.makes,
    this.models,
    this.categories,
    this.subcategories,
  });

  List<ProductMake> makes;
  List<ProductModel> models;
  List<ProductCategory> categories;
  List<ProductSubCategory> subcategories;

  factory CreateProductCategoriesModel.fromJson(Map<String, dynamic> json) =>
      CreateProductCategoriesModel(
        makes: json["makes"] == null
            ? null
            : List<ProductMake>.from(
                json["makes"].map((x) => ProductMake.fromJson(x))),
        models: json["models"] == null
            ? null
            : List<ProductModel>.from(
                json["models"].map((x) => ProductModel.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<ProductCategory>.from(
                json["categories"].map((x) => ProductCategory.fromJson(x))),
        subcategories: json["subcategories"] == null
            ? null
            : List<ProductSubCategory>.from(json["subcategories"]
                .map((x) => ProductSubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "makes": makes == null
            ? null
            : List<dynamic>.from(makes.map((x) => x.toJson())),
        "models": models == null
            ? null
            : List<dynamic>.from(models.map((x) => x.toJson())),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
        "subcategories": subcategories == null
            ? null
            : List<dynamic>.from(subcategories.map((x) => x.toJson())),
      };
}
