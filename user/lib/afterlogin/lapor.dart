// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/warga.dart';
import 'dashboard.dart';

class laporPage extends StatefulWidget {
  Warga profiles;
  laporPage({required this.profiles});
  @override
  _laporPageState createState() => _laporPageState();
}

class _laporPageState extends State<laporPage> {
  var now = DateFormat("EEEEE").format(DateTime.now());
  var bulan = DateFormat("dd MMM yyyy").format(DateTime.now());

  late bool _isFieldnama;
  late bool _isFieldrt;
  late bool _isFieldrw;
  TextEditingController _namacontroller = TextEditingController();
  TextEditingController _rtcontroller = TextEditingController();
  TextEditingController _rwcontroller = TextEditingController();
@override
  void initState() {
    if (widget.profiles != null) {
      if(widget.profiles.namawarga != "null"){
        _namacontroller.text = widget.profiles.namawarga;
      }else {
         _namacontroller.text = '';
      }
      if(widget.profiles.rt != "null"){
        _rtcontroller.text = widget.profiles.rt;
      }else {
        _rtcontroller.text = '';
      }
      if(widget.profiles.rw != "null"){
        _rwcontroller.text = widget.profiles.rw;
      }else {
        _rwcontroller.text = '';
      }
    }else{
      showDialog(context: context,
        builder: (context) {
          String contentText = "Data Anda Tidak Ditemukan";
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: Text("Title of Dialog"),
                content: Text(contentText),
                actions: <Widget>[
                  TextButton(
                  // onPressed: () => Navigator.pop(context),
                  //onPressed: (){ Navigator.of(context).pop(true);},
                    onPressed: () =>  Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Dashboard(),
                        ),
                        (route) => false,
                      ),
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      );
    }
    super.initState();
    //getProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF22215B),)
        ),
        title: Text(
          'Lapor ',
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Color(0xFF22215B)
          ),
        ),
        //centerTitle: true,
      ),
      body: ListView(
        children: [
          widget.profiles.status == "1" ?
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  height: 200,
                  width: 200,
                  //color: Colors.amber,
                  child: Image.asset(
                    'assets/img/notlapor.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Anda belum disetujui oleh Petugas",
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]
            )
          ) 
          :
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  height: 200,
                  width: 200,
                  //color: Colors.amber,
                  child: Image.asset(
                    'assets/img/lapor.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  now == "Friday" ? "Jumat, $bulan" : now == "Saturday" ? "Sabtu, $bulan" : now == "Sunday" ? "Minggu, $bulan" : now == "Monday" ? "Senin, $bulan" : now == "Tuesday" ? "Selasa, $bulan" : now == "Wednesday" ? "Rabu, $bulan" : "Kamis, $bulan",
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    TextField(
                      ///autocorrect: false,
                      controller: _namacontroller,
                      showCursor: true,
                      style: GoogleFonts.lato(
                        fontSize: 18,
                      ),
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          size: 23,
                        ),
                        border: OutlineInputBorder(
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.blue.shade700
                          )
                        ),
                        labelText: "Nama Warga",
                        labelStyle: GoogleFonts.lato(
                          fontSize: 18,
                        )
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            ///autocorrect: false,
                            controller: _rtcontroller,
                            showCursor: true,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.home,
                                size: 23,
                              ),
                              border: OutlineInputBorder(
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.blue.shade700
                                )
                              ),
                              labelText: "RT",
                              labelStyle: GoogleFonts.lato(
                                fontSize: 18,
                              )
                            ),
                          )
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            ///autocorrect: false,
                            controller: _rwcontroller,
                            showCursor: true,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.blue.shade700
                                )
                              ),
                              labelText: "RW",
                              labelStyle: GoogleFonts.lato(
                                fontSize: 18,
                              )
                            ),
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        ElevatedButton(
                          onPressed: (){
                            melapor();
                          }, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Kirim',
                                style: GoogleFonts.lato(
                                    fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.send),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:  Colors.blue,
                            fixedSize: Size(120, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  
  void melapor() async{
    var token;
    Uri upengajuan = Uri.parse("http://192.168.42.8/jadwal_sampah/public/api/melapor");
    _getToken() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      token = localStorage.getString('token');
      print("ini tokennya " + token);
    }
    _setHeaders() => {
      'Content-type' : 'application/json',
      'Accept' : 'application/json',
      'Authorization' : 'Bearer $token'
    };
    
    await _getToken();
    final response = await http.post(
      upengajuan,
      body: jsonEncode({
      "email" : widget.profiles.email,
      "desa_id"  : widget.profiles.desaId,
      "namawarga" : _namacontroller.text,
      "latitude": widget.profiles.latittude,
      "longitude" : widget.profiles.longitude,
    }),
    headers: _setHeaders());
    if(response.statusCode == 200){
      showDialog(
        context: context,
        builder: (context) {
          String contentText = "Anda Berhasil Melapor dan Sedang diproses oleh petugas....";
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: Text("Title of Dialog"),
                content: Text(contentText),
                actions: <Widget>[
                  TextButton(
                  // onPressed: () => Navigator.pop(context),
                  //onPressed: (){ Navigator.of(context).pop(true);},
                    onPressed: () =>  Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Dashboard(),
                        ),
                        (route) => false,
                      ),
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        },
      );
      print(response.body);
    }else{
      showDialog(
        context: context,
        builder: (context) {
          String contentText = "Laporan Anda Bukan Hari Ini";
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                //title: Text("Title of Dialog"),
                content: Text(contentText),
                actions: <Widget>[
                  TextButton(
                  // onPressed: () => Navigator.pop(context),
                  //onPressed: (){ Navigator.of(context).pop(true);},
                    onPressed: () =>  Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Dashboard(),
                        ),
                        (route) => false,
                      ),
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }
}