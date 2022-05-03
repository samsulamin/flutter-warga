// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:user/home.dart';
import 'package:user/model/provider.dart';
import 'package:user/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// void main(){
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: const LauncherPage(),
    // );
    return ChangeNotifierProvider(
      create: (ctx) => Auth(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LauncherPage(),
      ),
    );
  }
}