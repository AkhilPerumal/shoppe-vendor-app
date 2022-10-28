import 'package:carclenx_vendor_app/data/model/response/add_on_model.dart';
import 'package:carclenx_vendor_app/data/model/response/cateory_model.dart';

class ServiceModel {
  String id;
  String name;
  String categoryId;
  CategoryId categoryList;
  String carType;
  List<String> images;
  List<String> thumbnails;
  bool isActive;
  int price;
  List<AddOn> addOns;
  String description;
  String list;
  String createdAt;
  String updatedAt;
  int iV;
  List<dynamic> thumbURL;
  List<dynamic> imageURL;

  ServiceModel(
      {this.id,
      this.name,
      this.categoryId,
      this.categoryList,
      this.carType,
      this.images,
      this.thumbnails,
      this.isActive,
      this.price,
      this.addOns,
      this.description,
      this.list,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.thumbURL,
      this.imageURL});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    categoryId = json['categoryId'];
    categoryList = json['categoryDetails'] != null
        ? new CategoryId.fromJson(json['categoryDetails'])
        : null;
    carType = json['carType'];
    images = json['images'].cast<String>();
    thumbnails = json['thumbnails'].cast<String>();
    isActive = json['isActive'];
    price = json['price'];
    if (json['addOns'] != null) {
      addOns = <AddOn>[];
      json['addOns'].forEach((v) {
        addOns.add(new AddOn.fromJson(v));
      });
    }
    description = json['description'];
    list = json['list'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    thumbURL = json['thumbURL'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['categoryId'] = this.categoryId;
    if (this.categoryList != null) {
      data['categoryDetails'] = this.categoryList.toJson();
    }
    data['carType'] = this.carType;
    data['images'] = this.images;
    data['thumbnails'] = this.thumbnails;
    data['isActive'] = this.isActive;
    data['price'] = this.price;
    if (this.addOns != null) {
      data['addOns'] = this.addOns.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['list'] = this.list;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['thumbURL'] = this.thumbURL;
    data['imageURL'] = this.imageURL;
    return data;
  }
}
