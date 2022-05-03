// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class jadwalPage extends StatefulWidget {
  const jadwalPage({Key? key}) : super(key: key);
  @override
  _jadwalPageState createState() => _jadwalPageState();
}

class _jadwalPageState extends State<jadwalPage> {
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
          'Jadwal Laporan',
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Color(0xFF22215B)
          ),
        ),
        //centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              Text(
                "DESA \nPURBASANA",
                style: GoogleFonts.acme(
                  fontSize: 45,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Container(
                height: 80,
                width: 250,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          //scolor: Colors.amber.shade200,
                          width: 80,
                          child:Image.asset('assets/img/oke.png',
                            height: 50,
                            //width: 160,
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "SELASA",
                            style: GoogleFonts.lato(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),
                          ),
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
                  color: Colors.amber.shade200,
                  //margin: EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}