
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:user/model/api.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/model/laporan.dart';
import 'package:user/model/warga.dart';
import 'package:user/model/wargaku.dart';

class CallApi {
  var token;
  final String _url = 'http://192.168.42.8/jadwal-pengangkutan/public/api/';
  Uri baseUrl = Uri.parse("http://192.168.42.8/jadwal_sampah/public/api/login");
  Uri getProfil = Uri.parse("http://192.168.42.8/jadwal_sampah/public/api/getProfile");
  Uri upengajuan = Uri.parse("http://192.168.42.8/jadwal_sampah/public/api/updatePengajuan");
  Uri histori = Uri.parse("http://192.168.42.8/jadwal_sampah/public/api/notifikasi");
  Client client = Client();

  Future<bool> createProfile(Regist data) async {
    final response = await http.post(
      baseUrl,
      //Uri.parse("$baseUrl/api/Register"),
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  
  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    print("ini tokennya" + token);
  }

  postData(data, apiUrl) async{
    //Uri fullUrl = Uri.parse("http://192.168.42.149/jadwal_sampah/public/api/login");
    return await http.post(
        baseUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    final Uri urlasli = Uri.parse(fullUrl);
    await _getToken();
    return await http.get(
      urlasli,
      headers: _setHeaders()
    );
  }

  Future<List<Warga>> getwarga() async { 
    await _getToken();
    try {
      final response =  await http.get(
          getProfil,
          headers: _setHeaders(),
      );
      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        final parsed =json['data'].cast<Map<String, dynamic>>();
        return parsed.map<Warga>((json)=>Warga.fromJson(json)).toList();
      }else{
        return [];
      }
    } catch (e) {
      return [];
    }
    // if(response.statusCode == 200){
    //   return wargaFromJson(response.body);
    // }else{
    //    return wargaFromJson(response.body);
    // }
  }

  Future<List<Laporan>> getlaporan() async { 
    await _getToken();
    try {
      final response =  await http.get(
          histori,
          headers: _setHeaders(),
      );
      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        final parsed =json['data'].cast<Map<String, dynamic>>();
        return parsed.map<Laporan>((json)=>Laporan.fromJson(json)).toList();
      }else{
        return [];
      }
    } catch (e) {
      return [];
    }
    // if(response.statusCode == 200){
    //   return wargaFromJson(response.body);
    // }else{
    //    return wargaFromJson(response.body);
    // }
  }
   

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };
}