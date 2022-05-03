import 'dart:convert';

class mywarga{
  mywarga({
        required this.id,
        required this.desaId,
        required this.nik,
        required this.namawarga,
        required this.rt,
        required this.rw,
        // required this.kab,
        // required this.email,
        // required this.password,
        required this.latittude,
        required this.longitude,
        //required this.status,
        // required this.createdAt,
        // required this.updatedAt,
        // required this.deletedAt,
    });
    int id;
    int desaId;
    int nik;
    String namawarga;
    String rt;
    String rw;
    //String kab;
    //String email;
    //String password;
    String latittude;
    String longitude;
    // String status;
    // DateTime createdAt;
    // DateTime updatedAt;
    // DateTime deletedAt;

    factory mywarga.fromJson(Map<String, dynamic> json) => mywarga(
        id: json["id"],
        desaId: json["desa_id"],
        nik: json["nik"],
        namawarga: json["namawarga"].toString(),
        rt: json["rt"].toString(),
        rw: json["rw"].toString(),
        // kab: json["kab"].toString(),
        // email: json["email"].toString(),
        // password: json["password"].toString(),
        latittude: json["latittude"].toString(),
        longitude: json["longitude"].toString(),
        // status: json["status"].toString(),
        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
        // deletedAt: json["deleted_at"],
    );
    Map<String, dynamic> toJson() => {
        "id": id,
        "desa_id": desaId,
        "nik": nik,
        "namawarga": namawarga,
        "rt": rt,
        "rw": rw,
        "latittude": latittude,
        "longitude": longitude,
    };
}
List<mywarga> mywargaFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<mywarga>.from(data.map((item) => mywarga.fromJson(item)));
}

String? mywargaToJson(mywarga data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}