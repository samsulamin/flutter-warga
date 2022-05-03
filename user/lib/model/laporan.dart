class Laporan {
    Laporan({
        required this.email,
        required this.desaId,
        required this.latitude,
        required this.longitude,
        required this.status,
        required this.id,
    });

    String email;
    String desaId;
    String latitude;
    String longitude;
    String status;
    int id;

    factory Laporan.fromJson(Map<String, dynamic> json) => Laporan(
        email: json["email"].toString(),
        desaId: json["desa_id"].toString(),
        latitude: json["latitude"].toString(),
        longitude: json["longitude"].toString(),
        status: json["status"].toString(),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "desa_id": desaId,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "id": id,
    };
}