// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:user/model/url.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier{
  void signin(String email, String password, String verification) async {
    Uri url = Uri.parse(Urlku.regis);
    var response = await http.post(
      url,
      body: json.encode({
        "email" : email,
        "verificationId" : verification,
        "password" : password
      }),
    );

    print(json.decode(response.body));
  }
}