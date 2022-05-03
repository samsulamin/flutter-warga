// ignore_for_file: prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_images/carousel_images.dart';
import 'package:intl/intl.dart';
import 'package:user/afterlogin/bacaberita.dart';
import 'package:user/afterlogin/berita.dart';
import 'package:user/afterlogin/history.dart';
import 'package:user/afterlogin/jadwal.dart';
import 'package:user/afterlogin/lapor.dart';
import 'package:user/afterlogin/percent.dart';
import 'package:user/afterlogin/profile.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/login.dart';
import 'package:user/model/warga.dart';
import '../model/apiku.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var now = DateFormat("EEEEE").format(DateTime.now());
  var bulan = DateFormat("dd MMM yyyy").format(DateTime.now());
  late String name;
  
  late CallApi apiService;

  @override
  void initState() {
    super.initState();
    apiService = CallApi();
  }

  @override
  final List<String> listImages = [
    'assets/img/1.jpg',
    'assets/img/2.jpg',
    'assets/img/3.jpg',
    'assets/img/4.jpg',
  ];

  // _loadUserData() async{
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //    // var user = jsonDecode(localStorage.getString('user'));
  //     var user = json.decode
      
  //     if(user != null) {
  //       setState(() {
  //         name = user['name'];
  //       });
  //     }
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: 30),
          // Padding(
          //   padding: const EdgeInsets.only(right: 25.0, left: 25.0),
          //   child: Container(
          //     color: Colors.amber,
          //     height: 70,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Icon(Icons.person_pin_circle_outlined),
          //         Container(
          //           height: 40,
          //           width: 90,
          //           child: Card(
          //             child: Padding(
          //               padding: EdgeInsets.all(2),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Icon(Icons.circle, size: 15, color:  Colors.white),
          //                   SizedBox(width: 5),
          //                   Text("Aktif",
          //                     style: GoogleFonts.lato(
          //                       fontSize: 18,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15.0),
          //             ),
          //             elevation: 2,
          //             color: Colors.green,
          //             //margin: EdgeInsets.all(10),
          //           )
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(height: 10),
          CarouselImages(
            scaleFactor: 0.7,
            listImages: listImages,
            height: 220.0,
            borderRadius: 15.0,
            cachedNetworkImage: true,
            verticalAlignment: Alignment.bottomCenter,
            onTap: (index) {
              print('Tapped on page $index');
            },
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                FutureBuilder(
                  future: apiService.getwarga(),
                  builder: (BuildContext context, AsyncSnapshot<List<Warga>> snapshot) {
                   if (snapshot.hasError) {
                      return Center(
                        child: Text(
                            "GGL"),
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      List<Warga> profiles = snapshot.data!;
                      //return Text(profiles.length.toString(), style: TextStyle(fontSize: 100));
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Warga profile = profiles[index];
                          return Column(
                            children: [
                              profile.nik != 'null' ?
                              Container(
                                height: 125,
                                width: 400,
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10, left: 15, bottom: 15, right: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(),
                                            Text(
                                              now == "Friday" ? "Jumat, $bulan" : now == "Saturday" ? "Sabtu, $bulan" : now == "Sunday" ? "Minggu, $bulan" : now == "Monday" ? "Senin, $bulan" : now == "Tuesday" ? "Selasa, $bulan" : now == "Wednesday" ? "Rabu, $bulan" : "Kamis, $bulan",
                                              style: GoogleFonts.lato(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                        //SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircularPercentIndicator(
                                              animation: true,
                                              animationDuration: 2000,
                                              radius: 70,
                                              lineWidth: 10,
                                              percent: 0.5,
                                              progressColor: Colors.orange,
                                              backgroundColor: Colors.amber.shade100,
                                              circularStrokeCap: CircularStrokeCap.round,
                                              center: Text(
                                                "50%",
                                                style: GoogleFonts.lato(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 250,
                                              child: Text(
                                                "Laporan Anda sedang dalam proses...",
                                                style: GoogleFonts.lato(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    // side: BorderSide(
                                    //   width: 1
                                    // ),
                                  ),
                                  elevation: 2,
                                  //color: Colors.greenAccent.shade100,
                                  //margin: EdgeInsets.all(10),
                                )
                              ): 
                              Container(
                                height: 125,
                                width: 400,
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10, left: 15, bottom: 15, right: 15),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5),
                                        Text("Anda Belum memperbarui data anda tidak bisa melapor",
                                          style: GoogleFonts.lato(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(),
                                            ElevatedButton(
                                              onPressed: () async{
                                                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                  return ProfilePage(profiles: profile);
                                                    }));
                                                    if (result != null) {
                                                      setState(() {});
                                                    }
                                                  },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Perbarui',
                                                    style: GoogleFonts.lato(
                                                        fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary:  Colors.blue,
                                                fixedSize: Size(102, 30),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                                )
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 2,
                                  color: Colors.amber.shade100,
                                  //margin: EdgeInsets.all(10),
                                )
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    //color: Colors.black87,
                                    height: 100,
                                    width: 90,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Material(
                                          //elevation: 4.0,
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: Column(
                                            // alignment: Alignment.bottomCenter,
                                            // fit: StackFit.passthrough,
                                            children: [
                                              Ink.image(
                                                image: AssetImage("assets/icons/lapor.png"),
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                                child: InkWell(
                                                  onTap: () async {
                                                    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                      return laporPage(profiles: profile);
                                                        }));
                                                        if (result != null) {
                                                          setState(() {});
                                                        }
                                                  }
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Lapor", 
                                                    style:  GoogleFonts.lato(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                    )
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    //color: Colors.black87,
                                    height: 100,
                                    width: 90,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Material(
                                          //elevation: 4.0,
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: Column(
                                            // alignment: Alignment.bottomCenter,
                                            // fit: StackFit.passthrough,
                                            children: [
                                              Ink.image(
                                                image: AssetImage("assets/icons/riwayat.png"),
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                                child: InkWell(onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const historyPage())
                                                  );
                                                }),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Histori", 
                                                    style:  GoogleFonts.lato(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                    )
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    //color: Colors.black87,
                                    height: 100,
                                    width: 90,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Material(
                                          //elevation: 4.0,
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: Column(
                                            // alignment: Alignment.bottomCenter,
                                            // fit: StackFit.passthrough,
                                            children: [
                                              Ink.image(
                                                image: AssetImage("assets/icons/jadwal.png"),
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                                child: InkWell(onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const jadwalPage())
                                                  );
                                                }),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "jadwal", 
                                                    style:  GoogleFonts.lato(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                    )
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    //color: Colors.black87,
                                    height: 100,
                                    width: 90,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Material(
                                          //elevation: 4.0,
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: Column(
                                            // alignment: Alignment.bottomCenter,
                                            // fit: StackFit.passthrough,
                                            children: [
                                              Ink.image(
                                                image: AssetImage("assets/icons/berita.png"),
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                                child: InkWell(onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const beritaPage())
                                                  );
                                                }),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Berita", 
                                                    style:  GoogleFonts.lato(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                    )
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    //color: Colors.black87,
                                    height: 100,
                                    width: 90,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Material(
                                          //elevation: 4.0,
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: Column(
                                            // alignment: Alignment.bottomCenter,
                                            // fit: StackFit.passthrough,
                                            children: [
                                              Ink.image(
                                                image: AssetImage("assets/icons/profil.png"),
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                                child: InkWell(
                                                onTap: () async {
                                                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                  return ProfilePage(profiles: profile);
                                                    }));
                                                    if (result != null) {
                                                      setState(() {});
                                                    }
                                                  }
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Profile", 
                                                    style:  GoogleFonts.lato(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                    )
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    //color: Colors.black87,
                                    height: 100,
                                    width: 90,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Material(
                                          //elevation: 4.0,
                                          clipBehavior: Clip.hardEdge,
                                          color: Colors.transparent,
                                          child: Column(
                                            // alignment: Alignment.bottomCenter,
                                            // fit: StackFit.passthrough,
                                            children: [
                                              Ink.image(
                                                image: AssetImage("assets/icons/logout.png"),
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                                child: InkWell(onTap: () {
                                                  logout();
                                                }),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Logout", 
                                                    style:  GoogleFonts.lato(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                    )
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                      );
                    }else {
                      return Center(
                        child: Text("Not"),
                      );
                    }
                  }
                ),
                //_menuLapor(),
                //_menuBawah(),
                // SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(builder: (context) => Percent())
                //     // );
                //     logout();
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Perbarui',
                //         style: GoogleFonts.lato(
                //             fontSize: 20,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ],
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary:  Colors.blue,
                //     fixedSize: Size(102, 30),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10)
                //     )
                //   ),
                // ),
                SizedBox(height: 7),
                _berita(),
                SizedBox(height: 7),
                _berita(),
                SizedBox(height: 7),
                _berita(),
                SizedBox(height: 7),
                _berita(),
                SizedBox(height: 15),
                _lihatSemua(),
                SizedBox(height: 50),
              ],
            )
          ),
        ],
      ),
    );
  }
 
  Widget _berita(){
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        margin: EdgeInsets.all(15),
        height: 159,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 170,
                      child:Image.asset('assets/img/bg-ws.jpg',
                        height: 110,
                        //width: 160,
                      ),
                    ),
                    Container(),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 170,
                      child: Text(
                        'Small Step Big Impact, dari Limbah Sampah hingga Jadi Bernilai Ekonomis dan Bermanfaat',
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 170,
                      child: Text(
                        'Parapuan.co - Masalah lingkungan kini menjadi hal yang perlu menjadi perhatian...',
                        style: GoogleFonts.lato(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const bacaBerita())
                    );
                  }, 
                  child: Row(
                    children: [
                      Text(
                        "Baca Lengkap",
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          color: Colors.black
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18,)
                    ], 
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _lihatSemua(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const beritaPage())
            );
          }, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Berita Lain',
                style: GoogleFonts.lato(
                    fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.newspaper),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary:  Colors.blue,
            fixedSize: Size(155, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
          ),
        )
      ],
    );
  }

  // 
  void logout() async{
    
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      // Navigator.pushAndRemoveUntil(
        // context,
        // MaterialPageRoute(builder: (context)=>LoginPage()));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(),
          ),
          (route) => false,
        );
        print("Logout Sukses");
  }
}
