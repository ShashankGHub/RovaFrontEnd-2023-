import 'package:flutter/material.dart';
import 'package:rova_23/controllers/auth_controller.dart';
import 'package:rova_23/models/Authmodel.dart';
import 'package:rova_23/screens/OTPScreen.dart';
import 'package:rova_23/utlis/services/rest_api_services.dart';

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

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Sending OTP..."),
            ],
          ),
        );
      },
    );
  }

  void _dismissLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: EdgeInsets.all(16.0),
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
                child: ElevatedButton(
                  onPressed: () async {
                    if (validateName(clientNameController.text) == null &&
                        validatePhoneNumber(phoneNumberController.text) ==
                            null) {
                      _authmodel.name = clientNameController.text;
                      _authmodel.phone = phoneNumberController.text;

                      _showLoadingDialog(context);

                      var res = await _generateOtp(_authmodel);

                      _dismissLoadingDialog(context);
                      ApiBaseHelper.isLogin = false;
                      bool success = res["success"];
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpScreen(),
                          ),
                        );
                      } else {
                        String responseMessage =
                            res["errorMessage"] ?? res["resultMessage"] ?? "";
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
