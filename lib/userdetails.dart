import 'package:get/get.dart';

class UserDetails extends GetxController {
  String _email = '';
  String _phonenumber = '';

  set SetEmail(String email) {
    _email = email;
  }

  get email => _email;

  set SetPhonenumber(String phonenumber) {
    _phonenumber = phonenumber;
  }

  get phonenumber => _phonenumber;
}
