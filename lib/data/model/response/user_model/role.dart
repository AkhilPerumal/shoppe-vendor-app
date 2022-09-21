class Role {
  String id;
  String name;
  int v;

  Role({this.id, this.name, this.v});

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json['_id'] as String,
        name: json['name'] as String,
        v: json['__v'] as int,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        '__v': v,
      };
}
