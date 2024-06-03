class UserData {
  int userid;
  String full_name;
  String user_name;
  String email;
  String phonenumber;
  String password;

  UserData(
    this.userid,
    this.full_name,
    this.user_name,
    this.email,
    this.phonenumber,
    this.password,
  );

  Map<String, dynamic> toJson() => {
        'userid': userid.toString(),
        'full_name': full_name,
        'user_name': user_name,
        'email': email,
        'phonenumber': phonenumber,
        'password': password,
      };
}

