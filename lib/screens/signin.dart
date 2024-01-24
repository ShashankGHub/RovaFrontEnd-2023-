import 'package:flutter/material.dart';
import 'package:rova_23/controllers/login_controller.dart';
import 'package:rova_23/models/LoginModel.dart';
import 'package:rova_23/screens/OTPScreen.dart';
import 'package:rova_23/screens/signup.dart';
import 'package:rova_23/utlis/services/rest_api_services.dart';

TextEditingController phoneNumberController = TextEditingController();
LoginController _loginController = LoginController();
LoginModel _loginmodel = LoginModel(phoneNumber: '');

class LoginPage extends StatelessWidget {
  Future<dynamic> _loginByNumber(LoginModel loginModel) async {
    var result = await _loginController.loginByNumber(loginModel);
    return result;
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('images/logo.png', width: 250, height: 250),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(7.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: 'Phone no.',
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (validatePhoneNumber(phoneNumberController.text) == null) {
                    ApiBaseHelper.phoneNumber =
                        _loginmodel.phoneNumber = phoneNumberController.text;

                    ApiBaseHelper.isLogin = true;
                    // Show loader while signing in
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 10),
                              Text("Signing in..."),
                            ],
                          ),
                        );
                      },
                      barrierDismissible: false,
                    );

                    try {
                      var response = await _loginByNumber(_loginmodel);
                      Navigator.pop(context); // Close the loader

                      bool success = response["success"];
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OtpScreen()),
                        );
                      } else {
                        var responseMessage = (response["errorMessage"]) == null
                            ? response["resultMessage"]
                            : response["errorMessage"] +
                                "\n" +
                                response["resultMessage"];
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
                    } catch (error) {
                      Navigator.pop(
                          context); // Close the loader in case of an error
                      // Handle the error
                      print("Error: $error");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(185, 65, 137, 200),
                  foregroundColor: Color.fromARGB(255, 233, 238, 238),
                ),
                child: Text('Sign in'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider(thickness: 2)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'or',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 2)),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(width: 2.0, color: Colors.grey),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/google.jpg', width: 20, height: 20),
                      SizedBox(width: 10),
                      Text('Sign in with Google'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't have an account? ",
                    style: TextStyle(
                      color: Color(0xFF07243C),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      "Register here",
                      style: TextStyle(
                        color: Color.fromARGB(255, 27, 155, 191),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
