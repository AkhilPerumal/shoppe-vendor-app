import 'package:carclenx_vendor_app/data/model/response/cateory_model.dart';
import 'package:carclenx_vendor_app/data/model/response/order_details_model.dart';

class ServiceModel {
  String id;
  String name;
  CategoryId categoryId;
  String carType;
  List<String> images;
  List<String> thumbnails;
  bool isActive;
  int price;
  List<AddOns> addOns;
  String description;
  String list;
  String createdAt;
  String updatedAt;
  int iV;
  List<String> thumbURL;
  List<String> imageURL;

  ServiceModel(
      {this.id,
      this.name,
      this.categoryId,
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
    categoryId = json['categoryId'] != null
        ? new CategoryId.fromJson(json['categoryId'])
        : null;
    carType = json['carType'];
    images = json['images'].cast<String>();
    thumbnails = json['thumbnails'].cast<String>();
    isActive = json['isActive'];
    price = json['price'];
    if (json['addOns'] != null) {
      addOns = <AddOns>[];
      json['addOns'].forEach((v) {
        addOns.add(new AddOns.fromJson(v));
      });
    }
    description = json['description'];
    list = json['list'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    thumbURL = json['thumbURL'].cast<String>();
    imageURL = json['imageURL'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    if (this.categoryId != null) {
      data['categoryId'] = this.categoryId.toJson();
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
