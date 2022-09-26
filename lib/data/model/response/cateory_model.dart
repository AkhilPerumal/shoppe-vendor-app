class CategoryId {
  String sId;
  String name;
  List<String> images;
  List<String> thumbnails;
  bool isActive;
  String createdAt;
  String updatedAt;
  int iV;

  CategoryId(
      {this.sId,
      this.name,
      this.images,
      this.thumbnails,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CategoryId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    images = json['images'].cast<String>();
    thumbnails = json['thumbnails'].cast<String>();
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['images'] = this.images;
    data['thumbnails'] = this.thumbnails;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
