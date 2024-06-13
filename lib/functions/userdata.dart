import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  int userid;
  String fullName;
  String userName;
  String email;
  String age;
  String phoneNumber;
  String password;

  UserData({
    required this.userid,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.age,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'full_name': fullName,
      'user_name': userName,
      'email': email,
      'age': age,
      'phonenumber': phoneNumber,
      'password': password,
    };
    
  }
  
  
}
 
