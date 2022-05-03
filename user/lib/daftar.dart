// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/login.dart';


final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
class DaftarPage extends StatefulWidget {
  const DaftarPage({Key? key}) : super(key: key);
  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
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
          'Daftar',
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Color(0xFF22215B)
          ),
        ),
        //centerTitle: true,
      ),
     body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 30),
                _buildAvatar(),
                SizedBox(height: 40),
                _buildTfNik(),
                SizedBox(height: 20),
                _buildTfNama(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child:_buildTfRt(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child:_buildTfRw(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child:_buildTfLong(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.33,
                      child:_buildTfLat(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.13,
                      child:ElevatedButton(
                        onPressed: (){}, 
                        child: Center(
                          child: Icon(Icons.share_location_sharp, size: 22),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary:  Colors.blue,
                          fixedSize: Size(125, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                          )
                        ),
                      )
                    )
                  ],
                ),
                SizedBox(height: 20),
                _buildTfEmail(),
                SizedBox(height: 20),
                _buildTfPass(),
                SizedBox(height: 20),
                _buildButtonDaftar(),
                SizedBox(height: 50),
              ]
            )
          )    
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      height: 200,
      width: 200,
      //color: Colors.amber,
      child: Image.asset(
        'assets/img/register.png',
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTfNama() {
    return TextField(
      ///autocorrect: false,
      showCursor: true,
      style: GoogleFonts.lato(
        fontSize: 18,
      ),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          size: 30,
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
    );
  }
  
  Widget _buildTfNik() {
    return TextField(
      ///autocorrect: false,
      showCursor: true,
      style: GoogleFonts.lato(
        fontSize: 18,
      ),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          size: 30,
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
        labelText: "Nik",
        labelStyle: GoogleFonts.lato(
          fontSize: 18,
        )
      ),
    );
  }

  Widget _buildTfRt() {
    return TextField(
      ///autocorrect: false,
      showCursor: true,
      style: GoogleFonts.lato(
        fontSize: 18,
      ),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          size: 30,
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
    );
  }

  Widget _buildTfRw() {
    return TextField(
      ///autocorrect: false,
      showCursor: true,
      style: GoogleFonts.lato(
        fontSize: 18,
      ),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        // prefixIcon: Icon(
        //   Icons.person,
        //   size: 30,
        // ),
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
    );
  }

  Widget _buildTfLong() {
    return TextField(
      ///autocorrect: false,
      showCursor: true,
      style: GoogleFonts.lato(
        fontSize: 18,
      ),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          size: 30,
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
        labelText: "Longitude",
        labelStyle: GoogleFonts.lato(
          fontSize: 18,
        )
      ),
    );
  }

  Widget _buildTfLat() {
    return TextField(
      ///autocorrect: false,
      showCursor: true,
      style: GoogleFonts.lato(
        fontSize: 18,
      ),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        // prefixIcon: Icon(
        //   Icons.person,
        //   size: 30,
        // ),
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
    );
  }

  Widget _buildTfEmail() {
    return TextField(
      ///autocorrect: false,
      showCursor: true,
      style: GoogleFonts.lato(
        fontSize: 18,
      ),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          size: 30,
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
        labelText: "No. HP/Email",
        labelStyle: GoogleFonts.lato(
          fontSize: 18,
        )
      ),
    );
  }

  Widget _buildTfPass() {
    return TextField(
      obscureText: true,
      showCursor: true,
      style: GoogleFonts.lato(
        fontSize: 18,
      ),
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          size: 30,
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
        labelText: "Password",
        labelStyle: GoogleFonts.lato(
          fontSize: 18,
        )
      ),
    );
  }

  Widget _buildButtonDaftar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
               Text(
                "Sudah Daftar?",
                style: GoogleFonts.lato(
                  fontSize: 18,
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage())
                  );
                }, 
                child: Text(
                  "Login",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                  ),
                )
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: (){}, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Daftar',
                style: GoogleFonts.lato(
                    fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary:  Colors.blue,
            fixedSize: Size(120, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
          ),
        )
      ],
    );
  }
}

