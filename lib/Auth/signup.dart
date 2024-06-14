import 'package:btds_mobile/Auth/login.dart';
import 'package:btds_mobile/Darshboard/darshboard.dart';
import 'package:btds_mobile/data/img.dart';
import 'package:btds_mobile/snackbar.dart';
import 'package:btds_mobile/widget/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:btds_mobile/data/my_colors.dart';

class SignPForm extends StatefulWidget {
  const SignPForm({Key? key}) : super(key: key);

  @override
  State<SignPForm> createState() => _SignPFormState();
}

class _SignPFormState extends State<SignPForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final Snackbar snackbar = Snackbar();

  final SupabaseClient supabase = Supabase.instance.client;
  bool obscureText = true;
  bool _isLoading = false;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }

  bool isPasswordConfirmed(String password, String confirmPassword) {
    return password == confirmPassword;
  }
  

  Future<void> _signup() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await supabase.auth.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (response.user != null) {
        snackbar.displaymessage(context, 'User Created Successfully', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        snackbar.displaymessage(context, 'Sign Up Failed', false);
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
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                      "SignUP Page",
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
                  "Please sign up to continue",
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
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Your Email',
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Email';
                    }
                    if (!isValidEmail(_emailController.text)) {
                      return 'Enter valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: obscureText,
                  controller: _passwordController,
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
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: obscureText,
                  controller: _confirmPasswordController,
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
                      icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm the password';
                    }
                    if (!isPasswordConfirmed(_passwordController.text, _confirmPasswordController.text)) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _signup();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(double.maxFinite, 50),
                      backgroundColor: MyColors.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogInPage()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member? ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Log In',
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
