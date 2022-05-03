import 'dart:convert';
class Kecamatan {
    int id;
    String kecamatan;
    
    Kecamatan({
      required this.id,
      required this.kecamatan
    });

    factory Kecamatan.fromJson(Map<String, dynamic> json) => Kecamatan(
        id: json["id"],
        kecamatan: json["kecamatan"].toString()
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kecamatan": kecamatan
    };
}

List<Kecamatan> KecamatanFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Kecamatan>.from(data.map((item) => Kecamatan.fromJson(item)));
}

String KecamatanToJson(Kecamatan data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}