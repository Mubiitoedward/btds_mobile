import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSettingsPage extends StatelessWidget {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  void _changePassword() {
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Check if new password and confirm password match
    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'New password and confirm password do not match');
      return;
    }

    // Validate the strength of password
    if (newPassword.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters long');
      return;
    }

    // Implement logic to change password
    // For example:
    // authService.changePassword(currentPassword, newPassword);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: InputDecoration(labelText: 'Current Password'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _changePassword,
                child: Text('Change Password'),
              ),
              SizedBox(height: 32.0),
             
              
            ],
          ),
        ),
      ),
    );
  }
}
