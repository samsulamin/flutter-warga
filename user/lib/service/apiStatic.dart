import 'package:user/model/wargaku.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class apiStatic{
  var token;
  static final _url = 'http://192.168.42.23/jadwal-pengangkutan/public/api';
  static _urlget(){
    return _url;
  }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    print("ini tokennya" + token);
  }

  static Future<List<mywarga>> getwarga() async{
    try {
      final response = await http.get(Uri.parse("$_url/getProfile"));
      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        final parsed = json['data'].cast<Map<String, dynamic>>();
        return parsed.map<mywarga>((json)=>mywarga.fromJson(json)).toList();
      }else{
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future getprofil() async{
    var fullUrl = _url;
    final Uri urlgetprofile = Uri.parse(fullUrl);
    await _getToken();
    try {
      final response =  await http.get(
          urlgetprofile,
          headers: _setHeaders(),
      );
      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        final parsed = json['data'].cast<Map<String, dynamic>>();
        return parsed.map<mywarga>((json)=>mywarga.fromJson(json)).toList();
      }else{
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };
}