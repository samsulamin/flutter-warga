// To parse this JSON data, do
//
//     final Regist = RegistFromJson(jsonString);

import 'dart:convert';

class Regist {
    Regist({
        required this.email,
        required this.password,
        required this.verificationId,
    });

    String email;
    String password;
    String verificationId;

    factory Regist.fromJson(Map<String, dynamic> json) => Regist(
        email: json["email"],
        password: json["password"],
        verificationId: json["verificationId"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "verificationId": verificationId,
    };
}

List<Regist> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Regist>.from(data.map((item) => Regist.fromJson(item)));
}

String profileToJson(Regist data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
