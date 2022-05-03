
// ignore_for_file: prefer_typing_uninitialized_vari

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/model/warga.dart';

class Apimembara {
  // ignore: prefer_typing_uninitialized_variables
  var token;
  Uri upengajuan = Uri.parse("http://192.168.42.96/jadwal_sampah/public/api/updatePengajuan");
  
  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    print("ini tokennya" + token);
  }

    Future<bool> updateProfile(Warga data) async {
    await _getToken();
    final response = await http.put(
      upengajuan,
      headers: _setHeaders(),
      body: wargaToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };
}