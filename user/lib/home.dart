// ignore_for_file: avoid_unnecessary_containers, pref, prefer_const_constructors, sized_box_for_whitespace, unused_import, annotate_overrides, unnecessary_new
import 'package:flutter/material.dart';
import 'package:user/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'afterlogin/dashboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('token');
    //var user = jsonDecode(localStorage.getString('token'));
    if (userJson != null) {
      Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => Dashboard())
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                child: Image.asset(
                  'assets/img/bg-awan.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100,),
                    Container(
                      height: 250,
                      width: 250,
                      //color: Colors.amber,
                      child: Image.asset(
                        'assets/img/tr.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Selamat Datang',
                      style: GoogleFonts.lato(
                          fontSize: 20,
                        ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'LAPORKAN SAMPAH ANDA, BERSAMA MENJAGA LINGKUNGAN',
                        style: GoogleFonts.lato(
                          fontSize: 27,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 250,
                      child: Text(
                        'Menjaga kebersihan lingkungan bersama dengan tidak membuang sampah sembarangan, untuk menjaga kebersihan lingkungan dan mencegah kerusakan lingkungan.\n\n\n laporkan sampah anda yang penuh',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()));
                          }, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.input, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Login',
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            fixedSize: Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Register()));
                          }, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Daftar',
                                style: GoogleFonts.lato(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:  Colors.blue,
                            fixedSize: Size(150, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            )
                          ),
                        )
                      ],
                    ),
                    // SizedBox(height: 60),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children:[
                    //     Container(
                    //       height: 25,
                    //       width: 25,
                    //       child: Image.asset(
                    //         'assets/img/tegal.png',
                    //         fit: BoxFit.contain,
                    //       ),
                    //     ),
                    //     Text(
                    //       'Pemerintah Kabupaten Tegal',
                    //       style: TextStyle(
                    //         fontSize: 20)
                    //     ),
                    //   ] 
                    // )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
 }
