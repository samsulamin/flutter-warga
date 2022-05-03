// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_element
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/afterlogin/dashboard.dart';
import 'package:user/model/warga.dart';
import 'package:user/model/wargaku.dart';
import '../model/apiku.dart';
import '../model/editapi.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class ProfilePage extends StatefulWidget {
  Warga profiles;
  ProfilePage({required this.profiles});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<dynamic> _dataProvince = [];
  late String _getKec;
  String location ='Null, Press Button';
  var loading = false;
  CallApi apiService = CallApi();
  Apimembara apiMembara = Apimembara();
  late bool _isFielddesa;
  late bool _isFieldnik;
  late bool _isFieldnama;
  late bool _isFieldrt;
  late bool _isFieldrw;
  late bool _isFieldphone;
  late bool _isFieldlat;
  late bool _isFieldlong;
  TextEditingController _desacontroller = TextEditingController();
  TextEditingController _nikcontroller = TextEditingController();
  TextEditingController _namacontroller = TextEditingController();
  TextEditingController _rtcontroller = TextEditingController();
  TextEditingController _rwcontroller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _latcontroller = TextEditingController();
  TextEditingController _longcontroller = TextEditingController();

Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(()  {
    });
  }

  @override
  void initState() {
    if (widget.profiles != null) {
      //_isFieldnik = true;
       if(widget.profiles.desaId != "null"){
        _desacontroller.text = widget.profiles.desaId.toString();
      }else {
        _nikcontroller.text = '';
      }
      if(widget.profiles.nik != "null"){
        _nikcontroller.text = widget.profiles.nik.toString();
      }else {
        _nikcontroller.text = '';
      }
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
      if(widget.profiles.email != "null"){
        _phonecontroller.text = widget.profiles.email;
      }else {
        _phonecontroller.text = '';
      }
      if(widget.profiles.latittude != "null"){
        _latcontroller.text = widget.profiles.latittude;
      }else {
        _latcontroller.text = '';
      }
      if(widget.profiles.longitude != "null"){
        _longcontroller.text = widget.profiles.longitude;
      }else {
        _longcontroller.text = '';
      }
    }
    super.initState();
    apiService = CallApi();
    apiMembara = Apimembara();
    getProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF22215B),)
        ),
        title: Text(
          'Profil ',
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Color(0xFF22215B)
          ),
        ),
        //centerTitle: true,
      ),
      body: Container(
       // color: Colors.amber,
        child: FutureBuilder(
          future: apiService.getwarga(),
          builder: (BuildContext context, AsyncSnapshot<List<Warga>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Warga> profiles = snapshot.data!;
              //return Text(profiles.length.toString(), style: TextStyle(fontSize: 100));
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  //Warga profile = profiles[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Container(
                          height: 200,
                          width: 200,
                          //color: Colors.amber,
                          child: Image.asset(
                            'assets/img/profile.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 20),
                        widget.profiles.status == "0" ?
                        Container(
                          height: 40,
                          width: 90,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.circle, size: 15, color:  Colors.white),
                                  SizedBox(width: 5),
                                  Text("Aktif",
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 2,
                            color: Colors.green,
                            //margin: EdgeInsets.all(10),
                          )
                        ) : 
                        Container(
                          height: 40,
                          width: 110,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.circle, size: 15, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text("Pending",
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 2,
                            color: Colors.red,
                            //margin: EdgeInsets.all(10),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 20),
                              DropdownSearch<dynamic>(
                                mode: Mode.BOTTOM_SHEET,
                                isFilteredOnline: true,
                                showClearButton: true,
                                showSearchBox: true,
                                // items: _dataProvince.map((e) =>
                                //  DropdownMenuItem<String>(
                                //     child: Text(e['desa'].toString()),
                                //     value: e['id'].toString(),
                                //   )
                                // ).toList(),
                                // items: _dataProvince.map((e) => e['desa'].toString()).toList(),
                                items: _dataProvince.toList(),
                                // onChanged: print,
                                //onChanged: (value) => print(value?["id"] ?? null),
                                onChanged: (value) async {
                                  _getKec = value["id"].toString();
                                  // setState(() {
                                  //   // _getKec =value["id"].toString();
                                  // });
                                  //_getKec;
                                },
                                popupItemBuilder: (contect, item, isSelected) => ListTile(
                                  title: Text(item["desa"].toString(), style: GoogleFonts.lato(fontSize: 18)),
                                ),
                                dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?["desa"].toString() ?? "Belum Memilih Desa"),
                                dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 7
                                  ),
                                  prefixIcon: Icon(
                                    Icons.map_outlined,
                                    size: 25,
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
                                  hintText: "Pilih Desa Anda",
                                  hintStyle: GoogleFonts.lato(
                                    fontSize: 18,
                                  ),
                                  labelText: "Pilih Desa Anda",
                                  labelStyle: GoogleFonts.lato(
                                    fontSize: 18,
                                  )
                                ),
                              ),
                              
                              SizedBox(height: 10),
                              TextField(
                                ///autocorrect: false,
                                controller: _nikcontroller,
                                showCursor: true,
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                ),
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.key,
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
                                  labelText: "NIK",
                                  labelStyle: GoogleFonts.lato(
                                    fontSize: 18,
                                  )
                                ),
                              ), 
                              SizedBox(height: 10),
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
                              TextField(
                                ///autocorrect: false,
                                controller: _phonecontroller,
                                showCursor: true,
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                ),
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
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
                                  labelText: "No. Hp",
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
                                    width: MediaQuery.of(context).size.width * 0.42,
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
                                    width: MediaQuery.of(context).size.width * 0.42,
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
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.36,
                                    child: TextField(
                                      ///autocorrect: false,
                                      controller: _latcontroller,
                                      showCursor: true,
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                      ),
                                      textCapitalization: TextCapitalization.words,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.maps_home_work,
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
                                        labelText: "Latittude",
                                        labelStyle: GoogleFonts.lato(
                                          fontSize: 18,
                                        )
                                      ),
                                    )
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.33,
                                    child: TextField(
                                      ///autocorrect: false,
                                      controller: _longcontroller,
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
                                        labelText: "Longitude",
                                        labelStyle: GoogleFonts.lato(
                                          fontSize: 18,
                                        )
                                      ),
                                    )
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.13,
                                    child: ElevatedButton(
                                        onPressed: () async{
                                        Position position = await _getGeoLocationPosition();
                                        location ='Latittude: ${position.latitude} , Longitude: ${position.longitude}';
                                        GetAddressFromLatLong(position);
                                        setState(() {
                                          _latcontroller.text = position.latitude.toString();
                                          _longcontroller.text = position.longitude.toString();
                                        });
                                      }, 
                                      child: Icon(Icons.gps_fixed),
                                      style: ElevatedButton.styleFrom(
                                        primary:  Colors.blue,
                                        fixedSize: Size(30, 55),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)
                                        )
                                      ),
                                    // )
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 10,),
                                  ElevatedButton(
                                    onPressed: (){
                                      editData();
                                      //databaseHelper.editData("desa_id", "nik", "namawarga", "rt", "rw", "latittude", "longitude", "status");
                                      // int id = widget.profiles.id;
                                      // String email = widget.profiles.email;
                                      // String desa = _desacontroller.text.toString();
                                      // String kab = widget.profiles.kab;
                                      // String password = widget.profiles.password;
                                      // String status = widget.profiles.status;
                                      // String getdesa = _getKec.toString();
                                      // print(getdesa);
                                      // String nik = _nikcontroller.text.toString();
                                      // String nama = _namacontroller.text.toString();
                                      // String rt = _rtcontroller.text.toString();
                                      // String rw = _rwcontroller.text.toString();
                                      // String lat = _latcontroller.text.toString();
                                      // String long = _longcontroller.text.toString();
                                      // Warga profileW = Warga(id: id, desaId: desa, nik: nik, namawarga: nama, rt: rt, rw: rw, kab: kab, email: email, password: password, latittude: lat, longitude: long, status: status);
                                      // //Warga profile =new Warga(desaId: desa, nik: nik, namawarga: nama, rt: rt, rw: rw, latittude: lat, longitude: long);
                                      // if (desa.isEmpty || lat.isEmpty || long.isEmpty) {
                                      //   // ignore: deprecated_member_use
                                      //   _scaffoldState.currentState?.showSnackBar(
                                      //     SnackBar(
                                      //       content: Text("Please fill all field"),
                                      //     ),
                                      //   );
                                      //   return;
                                      // }
                                      // if(widget.profiles != null){
                                      //   profileW.id = widget.profiles.id;
                                      //   apiMembara.updateProfile(profileW).then((isSuccess) {
                                      //     if (isSuccess) {
                                      //       Navigator.of(context).push(
                                      //           new MaterialPageRoute(
                                      //             builder: (BuildContext context) => new Dashboard(),
                                      //           )
                                      //       );
                                      //     } else {
                                      //       _scaffoldState.currentState?.showSnackBar(SnackBar(
                                      //         content: Text("Update data failed"),
                                      //       ));
                                      //     }
                                      //   });
                                      // }

                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Ubah Data',
                                          style: GoogleFonts.lato(
                                              fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(Icons.edit),
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary:  Colors.blue,
                                      fixedSize: Size(160, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                      )
                                    ),
                                  )
                                ],
                              ),
                            ]
                          )
                        )
                      ]
                    )
                  );
                }
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Uri baseUrl = Uri.parse("http://192.168.42.8/jadwal_sampah/public/api/desa");
  void getProvince() async {
    final respose = await http.get(baseUrl);
    var listData = jsonDecode(respose.body);
    setState(() {
      _dataProvince = listData;
    });
    print("data : $listData");
  }

  void editData() async{
    String getdesa = _getKec.toString();
    var token;
    Uri upengajuan = Uri.parse("http://192.168.42.8/jadwal_sampah/public/api/updatewarga");
    _getToken() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      token = localStorage.getString('token');
      print("ini tokennya" + token);
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
      "id"    : widget.profiles.id,
      "email" : _phonecontroller.text,
      "desa_id"  : getdesa.toString(),
      "nik" : _nikcontroller.text,
      "namawarga" : _namacontroller.text,
      "rt" : _rtcontroller.text,
      "rw" : _rwcontroller.text,
      "latittude":_latcontroller.text,
      "longitude" : _longcontroller.text,
    }),
    headers: _setHeaders());
    if(response.statusCode == 200){
      showDialog(
        context: context,
        builder: (context) {
          String contentText = "Data Berhasil DIubah";
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
    }else{
      print("ini print token di update " + token.toString());
      print(response.body);
    }
  }
}