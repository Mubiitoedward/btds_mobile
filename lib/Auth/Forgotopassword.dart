import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // Supabase client initialization
  final SupabaseClient supabaseClient = SupabaseClient(
    'YOUR_SUPABASE_URL',
    'YOUR_SUPABASE_PUBLIC_ANON_KEY',
  );

  bool _isLoading = false;

  Future<void> _sendResetPasswordLink() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await supabaseClient.auth.resetPasswordForEmail(_emailController.text);

    setState(() {
      _isLoading = false;
    });

    // if (response == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(response)),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Password reset link sent! Check your email.')),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enter your email to receive a password reset link.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _sendResetPasswordLink,
                      child: Text('Send Reset Link'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
