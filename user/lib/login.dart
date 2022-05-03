// ignore_for_file: prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, unnecessary_new, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/afterlogin/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:user/model/apiku.dart';
import 'package:user/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loading = false;
  TextEditingController mailController = TextEditingController(text: "+62");
  TextEditingController passwordController = TextEditingController();

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
          'Login',
          style: GoogleFonts.lato(
            fontSize: 25,
            color: Color(0xFF22215B)
          ),
        ),
        //centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              height: 200,
              width: 200,
              //color: Colors.amber,
              child: Image.asset(
                'assets/img/login.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 70),
            TextField(
              controller: mailController,
              keyboardType: TextInputType.phone,
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
                labelText: "No.Hp / Email",
                labelStyle: GoogleFonts.lato(
                  fontSize: 18,
                )
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: (){
                          
                        }, 
                        child: Text(
                          "Lupa Password?",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register())
                          );
                        }, 
                        child: Text(
                          "atau Register",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    _login();
                  }, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
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
                    fixedSize: Size(125, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    )
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }

  void _login() async{

    var data = {
        'email' : mailController.text, 
        'password' : passwordController.text
    };
    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);
    if(body['success']){
      loading = true;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['data']['token']);
      localStorage.setString('user', json.encode(body['data']['user']));
      Navigator.push(
        context, new MaterialPageRoute(
            builder: (context) => Dashboard()
          )
      );
      //var userJson = localStorage.getString('token');
      //var user = json.decode(userJson);
      //print(userJson);
      print("Login Sukses");
      print(body);
    }else{
      print(body);
    }
  }
}