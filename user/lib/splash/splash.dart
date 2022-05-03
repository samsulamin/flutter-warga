// ignore_for_file: unnecessary_new, duplicate_ignore, annotate_overrides, prefer_const_constructors

// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:user/home.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key? key}) : super(key: key);
  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override

  void initState(){
    super.initState();
    startLaunching();
  }

  startLaunching()async{
    var duration = const Duration(seconds: 4);
    return new Timer(duration, (){
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_){
        return new HomePage();
      }));
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: new Center(
        child: Container(
          height: 230,
          color: Colors.white,
          child: Image.asset("assets/icons/splash.gif",fit: BoxFit.fill,),
        )
      ),
    );
  }
}