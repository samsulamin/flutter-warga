import 'dart:convert';
class Warga {
    int id;
    String desaId;
    String nik;
    String namawarga;
    String rt;
    String rw;
    String kab;
    String email;
    String password;
    String latittude;
    String longitude;
    String status;
    
    Warga({
      required this.id,
      required this.desaId,
      required this.nik,
      required this.namawarga,
      required this.rt,
      required this.rw,
      required this.kab,
      required this.email,
      required this.password,
      required this.latittude,
      required this.longitude,
      required this.status,
    });

    factory Warga.fromJson(Map<String, dynamic> json) => Warga(
        id: json["id"],
        desaId: json["desa_id"].toString(),
        nik: json["nik"].toString(),
        namawarga: json["namawarga"].toString(),
        rt: json["rt"].toString(),
        rw: json["rw"].toString(),
        kab: json["kab"].toString(),
        email: json["email"].toString(),
        password: json["password"].toString(),
        latittude: json["latittude"].toString(),
        longitude: json["longitude"].toString(),
        status: json["status"].toString()
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "desa_id": desaId,
        "nik": nik,
        "namawarga": namawarga,
        "rt": rt,
        "rw": rw,
        "kab": kab,
        "email": email,
        "password": password,
        "latittude": latittude,
        "longitude": longitude,
        "status": status
    };
}
List<Warga> wargaFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Warga>.from(data.map((item) => Warga.fromJson(item)));
}

String wargaToJson(Warga data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}