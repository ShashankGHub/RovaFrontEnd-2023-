import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rova_23/models/Authmodel.dart';
import 'package:rova_23/models/LoginModel.dart';
import 'package:rova_23/utlis/constants/api_end_points.dart';
import 'package:rova_23/utlis/helpers/app_exceptions.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../../models/VerifyOtpModel.dart';

class ApiBaseHelper {
  final String _baseUrl = "http://65.0.95.51/";
  final String _localUrl = "https://rova_solutions.acelucid.com/";
  //"https://localhost:7178/";
  final String signUpOtp = "api/Users/signUp";
  final String login = "api/Users/Login?phoneNumber=";

  final String verifySignUpOtp = "api/Users/verifySignup";
  final String verifyLoginOtp = "api/Users/verifyLogin";
  static String phoneNumber = "";
  static bool isLogin = false;

  Future<dynamic> get(String url) async {
    var responseJson;

    Map<String, String> headers = {
      "Accept": "application/json",
      //   "Authorization": token
    };

    try {
      final response =
          await http.get(Uri.parse(_baseUrl + url), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("connection_error");
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    var responseJson;
    var headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    try {
      final response = await http.post(Uri.parse(_baseUrl + url),
          body: jsonEncode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      //print('No net');
      throw FetchDataException("Connection error");
    }
    return responseJson;
  }

  Future<dynamic> uploadImageMediaPostRequest(String filename) async {
    var responseJson;
    try {
      Map<String, String> headers = {
        "accept": "application/json",
        "content-Type": "multipart/form-data"
      };

      var request = http.MultipartRequest(
          'POST', Uri.parse(_baseUrl + ApiEndPoints.tomatoEndPoints));
      request.headers.addAll(headers);
      request.files.add(http.MultipartFile('file',
          File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
          filename: filename.split("/").last));
      print("${request}");
      // var res = await request.send();

      // print("this is the response${res}");
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException("Connection error");
    }
    return responseJson;
  }

  Future<dynamic> generateOtp(Authmodel authmodel) async {
    var res;
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse(_localUrl + signUpOtp));

      request.body = json.encode(authmodel);
      request.headers.addAll(headers);
      http.Response response =
          await http.Response.fromStream(await request.send());
      res = jsonDecode(response.body);

      if (res["success"]) {
        ApiBaseHelper.phoneNumber = res['data']['phone'];
      }
    } catch (err) {}
    return res;
  }

  Future<dynamic> verifyOtp(VerifyOtpModel verifyOtpModel) async {
    var res;
    var headers = {
      'Content-Type': 'application/json',
    };
    var request;
    if (!isLogin) {
      request = http.Request('POST', Uri.parse(_localUrl + verifySignUpOtp));
    } else {
      request = http.Request('POST', Uri.parse(_localUrl + verifyLoginOtp));
    }
    request.body = json.encode(verifyOtpModel);
    request.headers.addAll(headers);
    http.Response response =
        await http.Response.fromStream(await request.send());
    res = jsonDecode(response.body);
    return res;
  }

  Future<dynamic> loginByNumber(LoginModel loginModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse(_localUrl + login + loginModel.phoneNumber));
    request.headers.addAll(headers);
    http.Response response =
        await http.Response.fromStream(await request.send());
    var res = jsonDecode(response.body);
    return res;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(errorHandler(response));
    case 401:
    case 403:
      throw UnauthorisedException(response.statusCode.toString());
    case 422:
    case 419:
      throw FetchDataException(errorHandler(response));
    default:
      throw FetchDataException(response.statusCode.toString());
    //'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

errorHandler(http.Response response) {
  var responseJson = json.decode(response.body.toString());
  final map = responseJson['errors'];
  if (!["", null, false, 0].contains(map)) {
    List errorsList = [];
    for (var key in map.keys) {
      errorsList.add(map[key]);
    }
    var errors = errorsList.expand((i) => i).toList();
    return errors.join('\n');
  } else {
    return responseJson['message'];
  }
}
