import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Constant {
  static String SatuURL = "Isi link API nya disini ya";
  static String DuaURL = "Isi link API nya disini ya";
  static String TigaURL = "Isi link API nya disini ya";
}

class DropdownProvider extends ChangeNotifier {
 
  bool loading = true;
  List listRiwayat = []; //tambahkan list dropdown
  List listQori = [];
  List listBahasa = [];
  var itemRiwayat;
  var itemQori;
  var itemBahasa; //tambahkan variabel


  Future<void> getRiwayat(BuildContext context) async {
    loading = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('accesToken');

    http.Response res = await http.get(Uri.parse(Constant.SatuURL),  //panggil dari dalam constant
        headers: {'Authorization': 'Bearer ${token}'});

    print(res.body);
    loading = false;
    notifyListeners();

    if (res.statusCode == 200) {
      var dataRiwayat = jsonDecode(res.body);
      listRiwayat = dataRiwayat['data'];
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error Get Data')));
    }
  }

  Future<void> getQori(BuildContext context) async {
    loading = true;
    notifyListeners();

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('accesToken');

    http.Response res = await http.get(Uri.parse(Constant.DuaURL), //panggil dari dalam constant
        headers: {'Authorization': 'Bearer ${token}'});
    print(res.body);
    loading = false;
    notifyListeners();

    if (res.statusCode == 200) {
      var dataQori = jsonDecode(res.body);
      listQori = dataQori['data'];
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error Get Data')));
    }
  }

  Future<void> getBahasa(BuildContext context) async {
    loading = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('accesToken');

    http.Response res = await http.get(Uri.parse(Constant.TigaURL),  //panggil dari dalam constant
        headers: {'Authorization': 'Bearer ${token}'});
    print(res.body);
    notifyListeners();

    if (res.statusCode == 200) {
      var dataBahasa = jsonDecode(res.body);
      listBahasa = dataBahasa['data']; // data diambil dari API
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Get Data")));
    }
  }
}