import 'package:btds_mobile/Auth/AuthService.dart';
import 'package:btds_mobile/Auth/Forgotopassword.dart';
import 'package:btds_mobile/Auth/signup.dart';
import 'package:btds_mobile/Darshboard/darshboard.dart';
import 'package:btds_mobile/data/img.dart';
import 'package:btds_mobile/snackbar.dart';
import 'package:btds_mobile/userdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:btds_mobile/data/my_colors.dart';
import 'package:btds_mobile/widget/my_text.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool obscureText = true;
  bool _isLoading = false;
  final snackbar = Snackbar();

  final SupabaseClient supabase = Supabase.instance.client;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await supabase.auth.signInWithPassword(
        email: _email.text,
        password: _password.text,
      );

      if (response.user != null) {
        snackbar.displaymessage(context, 'Logged in Successfully', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        snackbar.displaymessage(context, 'Login Failed', false);
      }
    } catch (e) {
      snackbar.displaymessage(context, 'Error: $e', false);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
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
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Email',
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    if (!isValidEmail(_email.text)) {
                      return 'Enter valid Email';
                    }
                    return null;
                  },
                ),
                Container(
                  height: 20,
                ),
                TextFormField(
                  obscureText: obscureText,
                  controller: _password,
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
                      icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the password';
                    }
                    return null;
                  },
                ),
                Container(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.transparent),
                  onPressed: () {
                    Get.to(ForgotPasswordPage());
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: MyColors.accent),
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _login();
                      }
                    },
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.accent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
                        'Not yet a member? ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 16,
                          color: MyColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
