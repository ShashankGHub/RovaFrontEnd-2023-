import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rova_23/controllers/verifyOtp_controller.dart';
import 'package:rova_23/models/VerifyOtpModel.dart';
import 'package:rova_23/screens/Home_page_rova.dart';

import '../utlis/services/rest_api_services.dart';

void main() {
  runApp(OtpScreen());
}

TextEditingController optTextController1 = TextEditingController();
TextEditingController optTextController2 = TextEditingController();
TextEditingController optTextController3 = TextEditingController();
TextEditingController optTextController4 = TextEditingController();

VerifyOtpController _verifyOtpController = VerifyOtpController();

VerifyOtpModel verifyOtpModel = VerifyOtpModel();

class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ENTER OTP",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildOtpBox(optTextController1),
                  SizedBox(width: 10.0),
                  buildOtpBox(optTextController2),
                  SizedBox(width: 10.0),
                  buildOtpBox(optTextController3),
                  SizedBox(width: 10.0),
                  buildOtpBox(optTextController4),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  String otpString = optTextController1.text +
                      optTextController2.text +
                      optTextController3.text +
                      optTextController4.text;
                  verifyOtpModel.enteredOtp = int.parse(otpString);
                  verifyOtpModel.phoneNumber = ApiBaseHelper.phoneNumber;

                  // Check if OTP is verified
                  var res = await verifyOtp(verifyOtpModel);
                  if (res["success"] || !res["success"]) {
                    // If OTP is verified, request location permission and navigate
                    await _requestLocationPermission(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else {
                    var userMessage = (res["errorMessage"]) == null
                        ? res["resultMessage"]
                        : res["errorMessage"] + "\n" + res["resultMessage"];
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text(userMessage),
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
                },
                child: Text("SUBMIT"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> verifyOtp(VerifyOtpModel verifyOtpModel) async {
    var result;
    try {
      result = await _verifyOtpController.verifyOtp(verifyOtpModel);
    } catch (err) {
      return err;
    }
    return result;
  }

  Future<void> _requestLocationPermission(BuildContext context) async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // Handle the case where the user denies the location permission
        return;
      }
    }

    // Navigate to the home screen after getting location permission
  }

  Widget buildOtpBox(TextEditingController textEditingController) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
      ),
      child: TextField(
        controller: textEditingController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
          counter: Offstage(),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
