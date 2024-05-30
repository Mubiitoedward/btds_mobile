import 'dart:convert';
import 'package:btds_mobile/functions/connection.dart';
import 'package:btds_mobile/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../snackbar.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationFunctions {
  final snackbar = Snackbar();
  Future<void> storeuid(String userid) async {
    SharedPreferences uid = await SharedPreferences.getInstance();
    uid.setString('userid', userid);
  }

  Future<String?> getuerid() async {
    SharedPreferences uid = await SharedPreferences.getInstance();
    return uid.getString('userid');
  }  

  getdata(String userid, BuildContext context) async {
    final userdetails = Get.put(UserDetails());

    try {
      var result =
          await http.post(Uri.parse(API.getdata), body: {'userid': userid});

      if (result.statusCode == 200) {
        var resbody = jsonDecode(result.body);

        if (resbody['accountfound'] == true) {
          Map<String, dynamic> userRecord = resbody['user'];
          userdetails.SetEmail = userRecord['email'];
          userdetails.SetPhonenumber = userRecord['phonenumber'];
        } else {
          // ignore: use_build_context_synchronously
          snackbar.displaymessage(
              context, 'Check your internet Connection', false);
        }
      } else {
        print('ERRRROOOOOOORRRRRRR');
      }
    } catch (e) {
      print(e.toString());
      snackbar.displaymessage(context, 'An Error occured', false);
    }
  }
}
