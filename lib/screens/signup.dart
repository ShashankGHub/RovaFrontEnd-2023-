import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:rova_23/controllers/auth_controller.dart';
import 'package:rova_23/models/Authmodel.dart';
import 'package:rova_23/screens/OTPScreen.dart';

//import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

TextEditingController phoneNumberController = TextEditingController();
TextEditingController clientNameController = TextEditingController();
AuthUserController _authUserController = AuthUserController();
Authmodel _authmodel = Authmodel();

class LoginScreen extends StatelessWidget {
  Future<dynamic> _generateOtp(Authmodel authmodel) async {
    var res = await _authUserController.generateOtp(authmodel);
    return res;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (!RegExp(r'^[a-zA-Z ]{1,25}$').hasMatch(value)) {
      return 'Name should contain alphabets and be up to 25 characters';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Phone number should be 10 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> res = {
      "errorMessage": "Error occurred!",
      "successMessage": "Operation successful!",
    };
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 180.0,
                height: 180.0,
                child: Image.asset(
                  'images/logo.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),

              // "Enter Name" text box
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: clientNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Enter Name',
                  ),
                  validator: validateName,
                ),
              ),

              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelText: 'Enter Mobile No.',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: validatePhoneNumber,
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (validateName(clientNameController.text) == null &&
                        validatePhoneNumber(phoneNumberController.text) ==
                            null) {
                      _authmodel.name = clientNameController.text;
                      _authmodel.phone = phoneNumberController.text;
                      var res = await _generateOtp(_authmodel);
                      bool success = res["success"];
                      if (success || !success) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpScreen()));
                      } else {
                        String responseMessage = (res["errorMessage"]) == null
                            ? res["resultMessage"]
                            : res["errorMessage"] + "\n" + res["resultMessage"];
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(responseMessage),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(222, 39, 156, 214),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                  ),
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFECEEF0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
