// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/afterlogin/bacaberita.dart';

class beritaPage extends StatefulWidget {
  const beritaPage({Key? key}) : super(key: key);
  @override
  _beritaPageState createState() => _beritaPageState();
}

class _beritaPageState extends State<beritaPage> {
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
          'Berita',
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Color(0xFF22215B)
          ),
        ),
        //centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 10),
                _berita(),
                SizedBox(height: 5),
                _berita(),
                SizedBox(height: 5),
                _berita(),
                SizedBox(height: 5),
                _berita(),
                SizedBox(height: 5),
                _berita(),
                SizedBox(height: 5),
                _berita(),
              ],
            ),
          ),
        ]
      )
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
                    SizedBox(
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
                    SizedBox(
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
                    SizedBox(
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
}