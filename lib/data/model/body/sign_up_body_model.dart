import 'dart:convert';

SignUpBody signUpBodyFromJson(String str) =>
    SignUpBody.fromJson(json.decode(str));

String signUpBodyToJson(SignUpBody data) => json.encode(data.toJson());

class SignUpBody {
  SignUpBody({
    this.name,
    this.place,
    this.state,
    this.district,
    this.phone,
    this.email,
    this.username,
    this.password,
    this.experience,
    this.availability,
  });

  String name;
  String place;
  String state;
  String district;
  String phone;
  String email;
  String username;
  String password;
  Experience experience;
  String availability;

  factory SignUpBody.fromJson(Map<String, dynamic> json) => SignUpBody(
        name: json["name"] == null ? null : json["name"],
        place: json["place"] == null ? null : json["place"],
        state: json["state"] == null ? null : json["state"],
        district: json["district"] == null ? null : json["district"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        experience: json["experience"] == null
            ? null
            : Experience.fromJson(json["experience"]),
        availability:
            json["availability"] == null ? null : json["availability"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "place": place == null ? null : place,
        "state": state == null ? null : state,
        "district": district == null ? null : district,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "experience": experience == null ? null : experience.toJson(),
        "availability": availability == null ? null : availability,
      };
}

class Experience {
  Experience({
    this.total,
    this.carspa,
    this.mechanical,
    this.quickhelp,
    this.shoppe,
  });

  int total;
  int carspa;
  int mechanical;
  int quickhelp;
  int shoppe;

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        total: json["total"] == null ? null : json["total"],
        carspa: json["carspa"] == null ? null : json["carspa"],
        mechanical: json["mechanical"] == null ? null : json["mechanical"],
        quickhelp: json["quickhelp"] == null ? null : json["quickhelp"],
        shoppe: json["shoppe"] == null ? null : json["shoppe"],
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "carspa": carspa == null ? null : carspa,
        "mechanical": mechanical == null ? null : mechanical,
        "quickhelp": quickhelp == null ? null : quickhelp,
        "shoppe": shoppe == null ? null : shoppe,
      };
}
