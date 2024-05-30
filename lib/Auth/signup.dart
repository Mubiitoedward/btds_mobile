//import 'dart:html';

import 'dart:convert';

import 'package:btds_mobile/Auth/login.dart';
import 'package:btds_mobile/Darshboard/Diagonise.dart';
import 'package:btds_mobile/functions/connection.dart';
import 'package:btds_mobile/functions/userdata.dart';
import 'package:btds_mobile/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:btds_mobile/data/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SignPForm extends StatefulWidget {
  const SignPForm({Key? key}) : super(key: key);

  @override
  State<SignPForm> createState() => _SignPFormState();
}

class _SignPFormState extends State<SignPForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController full_name = TextEditingController();
  final TextEditingController user_name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final snackbar = Snackbar();
  bool obscureText = true;
  bool _isLoading = false;
  bool signup = false;

  bool isValidEmail(String email) {
    // Use a regular expression to validate the email format
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }

  bool isPasswordConfirmed(String password, String confirmpassword) {
    return password == confirmpassword;
  }

  registerUser() async {
    UserData userdata = UserData(
      1,
      full_name.text.trim(),
      user_name.text.trim(),
      email.text.trim(),
      phonenumber.text.trim(),
      password.text.trim(),
    );
    try {
      var result =
          await http.post(Uri.parse(API.signup), body: userdata.toJson());
      if (result.statusCode == 200) {
        var resbody = await jsonDecode(result.body);
        if (resbody['signup'] == true) {
          Fluttertoast.showToast(
              msg: "congrats!! you are log in successfully.");
        } else {
          Fluttertoast.showToast(msg: "An Error occured, try again.");
        }
      }
    } catch (e) {
      snackbar.displaymessage(context, 'An Error occured', false);
    }
  }

  validateEmail() async {
    try {
      var result = await http.post(Uri.parse(API.validateEmail),
          body: {'email': email.text.toString()});

      if (result.statusCode == 200) {
        var resbody = jsonDecode(result.body);
        if (resbody['emailfound'] == true) {
          Fluttertoast.showToast(msg: 'User already exists');
        } else {
          await registerUser();
        }
      } else {
        print('ERRRROOOOOOORRRRRRR');
      }
    } catch (e) {
      print(e.toString());
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
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: full_name,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'full name',
                      hintStyle: TextStyle(fontSize: 16),
                      suffixIcon: Icon(Icons.near_me)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the full name';
                    }
                    if (!isValidEmail(email.text)) {
                      return 'Enter valid full name';
                    }
                    return null;
                  },
                ),
                Container(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: user_name,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Your username',
                      hintStyle: TextStyle(fontSize: 16),
                      suffixIcon: Icon(Icons.person)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the username';
                    }
                    if (!isValidEmail(email.text)) {
                      return 'Enter valid username';
                    }
                    return null;
                  },
                ),
                Container(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Your email',
                      hintStyle: TextStyle(fontSize: 16),
                      suffixIcon: Icon(Icons.email)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Email';
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
                  keyboardType: TextInputType.phone,
                  controller: phonenumber,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(fontSize: 16),
                      suffixIcon: Icon(Icons.phone)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the phone number';
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
                    if (!isPasswordConfirmed(
                        password.text, confirmpassword.text)) {
                      return 'Please enter matching passwords';
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
                    controller: confirmpassword,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Confirm Password',
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
                    }),
                Container(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        await validateEmail();
                        setState(() {
                          _isLoading = false;
                        });
                        if (signup) {
                          // await newuser.storeuid(userRecord['userid']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Diagonise()
                                  // BottomBar(index: 0,)
                                  ));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(double.maxFinite, 50),
                      backgroundColor: MyColors.accent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogInPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Aready member? ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'LogIn',
                        style: TextStyle(
                            fontSize: 16,
                            color: MyColors.accent,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
