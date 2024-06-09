import 'dart:convert';

import 'package:btds_mobile/Auth/Authentication.dart';
import 'package:btds_mobile/Auth/signup.dart';
import 'package:btds_mobile/data/img.dart';
import 'package:btds_mobile/functions/connection.dart';
import 'package:btds_mobile/snackbar.dart';
import 'package:btds_mobile/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:btds_mobile/data/my_colors.dart';
import 'package:btds_mobile/widget/my_text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Darshboard/Diagonise.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool obscureText = true;
  bool _isLoading = false;
  bool login = false;
  final newuser = AuthenticationFunctions();
  final snackbar = Snackbar();

  Map<String, dynamic> userRecord = {};
  final userdetails = Get.put(UserDetails());
  bool isValidEmail(String email) {
    // Use a regular expression to validate the email format
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }

  loginUser() async {
    Map<String, dynamic> toJson = {
      'email': email.text.toString(),
      'password': password.text.toString()
    };
    try {
      var result = await http.post(Uri.parse(API.login), body: toJson);

      if (result.statusCode == 200) {
        print('llllllllllllll');
        var resbody = jsonDecode(result.body);

        bool account = resbody["accountfound"];

        if (resbody['accountfound'] == true) {
          snackbar.displaymessage(context, 'Logged in', true);
          userRecord = resbody['user'];
          print(userRecord);
          setState(() {
            login = true;
          });
        } else {
          snackbar.displaymessage(context, 'An Error occured', false);
        }
      } else {
        snackbar.displaymessage(context, 'An Error occured', false);
      }
    } catch (e) {
      snackbar.displaymessage(context, 'An Error occured', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryDark,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: MyColors.primaryDark,
          statusBarIconBrightness: Brightness.dark,
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(150),
          child: Container(
            padding: EdgeInsets.fromLTRB(60, 15, 0, 25),
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: Image.asset(
                        Img.get('BT2-01.png'),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Login",
                      style: MyText.headline(context)!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 10,
                ),
                Text(
                  "Please sign in to continue",
                  style: MyText.body1(context)!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: email,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 16),
                        suffixIcon: Icon(Icons.email)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email';
                      }
                       if (!isValidEmail(email.text)) {
                        return 'Enter valid Email';
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 20,
                  ),
                  TextFormField(
                    //  keyboardType: TextInputType.,
                    obscureText: obscureText,
                    controller: password,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 16),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the password';
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 5,
                  ),
                  // Row(children: [
                  //   Checkbox(
                  //     value: false,
                  //     onChanged: (value) {},
                  //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //   ),
                  //   Text(
                  //     "Remember me",
                  //     style: MyText.body1(context)!
                  //         .copyWith(color: Colors.grey[600]),
                  //   ),
                  // ]),
                  Container(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          await loginUser();
                          setState(() {
                            _isLoading = false;
                          });
                          if (login) {
                            await newuser.storeuid(userRecord['userid']);
                            userdetails.SetEmail = userRecord['email'];
                            userdetails.SetPhonenumber =
                                userRecord['email'];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Diagonise()));
                          }
                        }
                      },
                      child: Text(
                        "Login",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.accent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => SignPForm());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Notyet a member? ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'SignUp',
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColors.accent,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
