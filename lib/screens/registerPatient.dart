import 'package:btds_mobile/Auth/login.dart';
import 'package:btds_mobile/Darshboard/Diagonise.dart';
import 'package:btds_mobile/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:btds_mobile/data/my_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Patients_Reg extends StatefulWidget {
  const Patients_Reg({Key? key}) : super(key: key);

  @override
  State<Patients_Reg> createState() => _Patients_RegState();
}

class _Patients_RegState extends State<Patients_Reg> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final Snackbar snackbar = Snackbar();

  bool _isLoading = false;

  Future<void> addUserToSupabase({
    required String fullName,
    required String gender,
    required int age,
    required String phoneNumber,
    required String address,
  }) async {
    final response =
        await Supabase.instance.client.from('Patients_Reg').insert([
      {
        'Full_name': fullName,
        'Gender': gender,
        'Age': age,
        'Telephone_Number': phoneNumber,
        'Address': address,
      }
    ]);

    // if (response.error != null) {
    //   throw Exception('Failed to add user: ${response.error!.message}');
    // } else {
    //   print("User added successfully");
    // }
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await addUserToSupabase(
          fullName: _fullNameController.text,
          gender: _genderController.text,
          age: int.parse(_ageController.text),
          phoneNumber: _phoneNumberController.text,
          address: _addressController.text,
        );

        snackbar.displaymessage(context, 'User Created Successfully', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Diagonise()),
        );
      } catch (e) {
        snackbar.displaymessage(context, 'Error: $e', false);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _genderController.dispose();
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
                  keyboardType: TextInputType.text,
                  controller: _fullNameController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Full Name',
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIcon: Icon(Icons.person_2_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Age',
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIcon: Icon(Icons.lock_clock_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _addressController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Your Address',
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneNumberController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _genderController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Gender',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _signup();
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
                            'Save Patient',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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
