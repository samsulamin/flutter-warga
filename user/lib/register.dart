// ignore_for_file: prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, avoid_print, unnecessary_new, prefer_final_fields, unused_import, unused_element

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user/afterlogin/dashboard.dart';
import 'package:user/login.dart';
import 'package:user/model/api.dart';
import 'package:user/model/apiku.dart';
import 'package:http/http.dart' as http;
import 'package:user/model/provider.dart';
import 'package:user/model/url.dart';
import 'package:firebase_core/firebase_core.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = new GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController(text: "+62");
  TextEditingController otpController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  bool passVisibility = false;
  String verificationID = "";
  CallApi _apiService = CallApi();

  Duration get logintime => Duration(milliseconds: 2250);
  Future<String> _signup(Register data){
    return Future.delayed(logintime).then((_) {
      Provider.of<Auth>(context, listen: false);
      return null.toString();
    });
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
          // ignore: prefer_const_constructors
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF22215B),)
        ),
        title: Text(
          'Register',
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Color(0xFF22215B)
          ),
        ),
        //centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(height: 50),
              Container(
                height: 200,
                width: 200,
                //color: Colors.amber,
                child: Image.asset(
                  'assets/img/register.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 70),
              TextField(
                controller: phoneController,
                showCursor: true,
                keyboardType: TextInputType.phone,
                style: GoogleFonts.lato(
                  fontSize: 18,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_android,
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
                  labelText: "No.Hp / Email",
                  labelStyle: GoogleFonts.lato(
                    fontSize: 18,
                  )
                ),
              ),
              SizedBox(height: 10),
              Visibility(
                visible: otpVisibility,
                child: TextField(
                  controller: otpController,
                  autocorrect: false,
                  keyboardType: TextInputType.phone,
                  showCursor: true,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                  ),
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.numbers,
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
                    labelText: "OTP",
                    labelStyle: GoogleFonts.lato(
                      fontSize: 18,
                    )
                  ),
                ),
              ),
              SizedBox(height: 10),
              Visibility(
                visible: passVisibility,
                child: TextField(
                  controller: passController,
                  autocorrect: false,
                  showCursor: true,
                  obscureText: true,
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
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  ElevatedButton(
                    onPressed: (){
                      if(otpVisibility){
                        //verifyOTP();
                        submit();
                      }else{
                        loginWithPhone();
                      }
                    }, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          otpVisibility ? 'Register' : "Minta OTP",
                          style: GoogleFonts.lato(
                              fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.input),
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
              ),
            ],
          ),
        ),
      )
    );
  }


  void loginWithPhone() async {
    String email = phoneController.text;
    if (email == "+62" || email.isEmpty){
      final snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Text("Nomer HP Harus Benar"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }else{
      auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value){
            print("You are logged in successfully");
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          otpVisibility = true;
          passVisibility = true;
          verificationID = verificationId;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {

        },
      );
    }
  }

  void verifyOTP() async {
    
  // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);

  // await auth.signInWithCredential(credential).then((value){
  //   print("You are logged in successfully");
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const Dashboard()));
  // });
    String email = phoneController.text.toString();
    String password = passController.text;
    String verificationId = otpController.text;
    Regist profile = Regist(email: email, password: password, verificationId: verificationId);
    _apiService.createProfile(profile).then((isSuccess) {
      if (isSuccess){
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
        auth.signInWithCredential(credential).then((value){
          print("You are logged in successfully");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
        });
        print("Berhasil");
        print(email);
        print(password);
        print(verificationId);
      } else {
        print("Gagal");
        print(email);
        print(password);
        print(verificationId);
      }
    });
  }

  void submit() async {
    String email = phoneController.text;
    String password = passController.text;
    String verification = otpController.text;

    if (email.isEmpty || password.isEmpty || verification.isEmpty) {
      final snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Text("Tidak Boleh Ada yang Kosong.!"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }else{
      final response = await http.post(Uri.parse(Urlku.center + '/register'),
      body: {
        "email" : email,
        "verificationId" : verification,
        "password" : password
      });
      
      // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
      // auth.signInWithCredential(credential).then((value){print("You are logged in successfully");});
      if(response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) {
            String contentText = "Registrasi Berhasil, Silahkan Login";
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  //title: Text("Title of Dialog"),
                  content: Text(contentText),
                  actions: <Widget>[
                    TextButton(
                    // onPressed: () => Navigator.pop(context),
                    //onPressed: (){ Navigator.of(context).pop(true);},
                      onPressed: () =>  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage())
                      ),
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          },
        );
        print("Berhasil");
        print(phoneController);
        print(otpController);
        print(passController);
      }else{
        showDialog(
          context: context,
          builder: (context) {
            String contentText = "Nomor Sudah Terdaftar";
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  //title: Text("Title of Dialog"),
                  content: Text(contentText),
                  actions: <Widget>[
                    TextButton(
                    onPressed: (){ Navigator.of(context).pop(true);},
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
}