class AddOnsModel {
  String name;
  int price;
  String sId;

  AddOnsModel({this.name, this.price, this.sId});

  AddOnsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['_id'] = this.sId;
    return data;
  }
}
