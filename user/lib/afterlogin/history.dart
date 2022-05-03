// ignore_for_file: camel_case_types, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:user/model/laporan.dart';

import '../model/apiku.dart';

class historyPage extends StatefulWidget {
  const historyPage({Key? key}) : super(key: key);
  @override
  _historyPageState createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {
  var now = DateFormat("EEEEE").format(DateTime.now());
  var bulan = DateFormat("dd MMM yyyy").format(DateTime.now());
  late CallApi apiService;

  @override
  void initState() {
    super.initState();
    apiService = CallApi();
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
          'Riwayat Laporan',
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Color(0xFF22215B)
          ),
        ),
        //centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child:ListView(
          children: [
            SizedBox(height: 10),
            FutureBuilder(
              future: apiService.getlaporan(),
              builder: (BuildContext context, AsyncSnapshot<List<Laporan>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        "GGL"),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<Laporan> profiles = snapshot.data!;
                  //return Text(profiles.length.toString(), style: TextStyle(fontSize: 100));
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Laporan profile = profiles[index];
                      return Column(
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Container(
                              margin: EdgeInsets.all(15),
                              height: 103,
                              width: 400,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 5),
                                  Container(
                                    width: 90,
                                    child:Image.asset('assets/img/mantap.png',
                                      height: 80,
                                      //width: 160,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  profile.status == '1' ?
                                  Container(
                                    width: 225,
                                    margin: EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:  MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 158,
                                              child: Text(
                                                profile.email,
                                                style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              //color: Colors.amber,
                                              width: 158,
                                              child: Text(
                                                now == "Friday" ? "Jumat, $bulan" : now == "Saturday" ? "Sabtu, $bulan" : now == "Sunday" ? "Minggu, $bulan" : now == "Monday" ? "Senin, $bulan" : now == "Tuesday" ? "Selasa, $bulan" : now == "Wednesday" ? "Rabu, $bulan" : "Kamis, $bulan",
                                                style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            Container(
                                              height: 35,
                                              width: 100,
                                              child: Card(
                                                child: Padding(
                                                  padding: EdgeInsets.only(bottom: 2),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.circle, size: 15, color:  Colors.white),
                                                      SizedBox(width: 5),
                                                      Text("Sukses",
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
                                            )
                                          ],
                                        ),
                                        Icon(Icons.check_circle_rounded, size: 45, color: Colors.green,),
                                      ],
                                    ),
                                  ):
                                  Container(
                                    width: 225,
                                    margin: EdgeInsets.only(top: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:  MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 158,
                                              child: Text(
                                                profile.email,
                                                style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              //color: Colors.amber,
                                              width: 158,
                                              child: Text(
                                                now == "Friday" ? "Jumat, $bulan" : now == "Saturday" ? "Sabtu, $bulan" : now == "Sunday" ? "Minggu, $bulan" : now == "Monday" ? "Senin, $bulan" : now == "Tuesday" ? "Selasa, $bulan" : now == "Wednesday" ? "Rabu, $bulan" : "Kamis, $bulan",
                                                style: GoogleFonts.lato(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            Container(
                                              height: 35,
                                              width: 110,
                                              child: Card(
                                                child: Padding(
                                                  padding: EdgeInsets.only(bottom: 2),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.circle, size: 15, color:  Colors.white),
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
                                                color: Colors.amber,
                                                //margin: EdgeInsets.all(10),
                                              )
                                            ),
                                          ],
                                        ),
                                        Icon(Icons.running_with_errors_sharp, size: 45, color: Colors.amber,),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10)
                        ]
                      );
                    }
                  );
                }else {
                  return Center(
                    child: Text("Not"),
                  );
                }
              }
            )
          ]
        ),
      )
    );
  }

  Widget _card(){
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        margin: EdgeInsets.all(15),
        height: 100,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //color: Colors.amber,
              width: 100,
              child:Image.asset('assets/img/mantap.png',
                height: 90,
                //width: 160,
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //color: Colors.amber,
                  width: 150,
                  child: Text(
                    "Berhasil diangkut",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  //color: Colors.amber,
                  width: 150,
                  child: Text(
                    now == "Friday" ? "Jumat, $bulan" : now == "Saturday" ? "Sabtu, $bulan" : now == "Sunday" ? "Minggu, $bulan" : now == "Monday" ? "Senin, $bulan" : now == "Tuesday" ? "Selasa, $bulan" : now == "Wednesday" ? "Rabu, $bulan" : "Kamis, $bulan",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  //color: Colors.amber,
                  width: 150,
                  child: Text(
                    "Beres",
                    style: GoogleFonts.lato(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(),
                Container(
                  //scolor: Colors.amber,
                  width: 80,
                  child:Image.asset('assets/img/oke.png',
                    height: 55,
                    //width: 160,
                  ),
                ),
                Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}