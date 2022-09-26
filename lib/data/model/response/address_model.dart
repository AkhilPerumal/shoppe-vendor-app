class AddressModel {
  String sId;
  String name;
  String mobile;
  String house;
  String street;
  String city;
  String state;
  String pincode;
  String landmark;
  String type;
  List<double> location;
  String user;
  bool isDefault;
  String createdAt;
  String updatedAt;
  int iV;

  AddressModel(
      {this.sId,
      this.name,
      this.mobile,
      this.house,
      this.street,
      this.city,
      this.state,
      this.pincode,
      this.landmark,
      this.type,
      this.location,
      this.user,
      this.isDefault,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AddressModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    mobile = json['mobile'].toString();
    house = json['house'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'].toString();
    landmark = json['landmark'];
    type = json['type'];
    location = json['location'].cast<double>();
    user = json['user'];
    isDefault = json['isDefault'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['house'] = this.house;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['type'] = this.type;
    data['location'] = this.location;
    data['user'] = this.user;
    data['isDefault'] = this.isDefault;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
