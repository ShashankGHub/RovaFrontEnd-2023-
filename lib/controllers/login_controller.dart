import 'package:flutter/material.dart';
import 'package:rova_23/models/LoginModel.dart';
import 'package:rova_23/repositories/login_repository.dart';

class LoginController {
  LoginRepository _loginRepository = LoginRepository();
  final ValueNotifier<bool> isLoadingState = ValueNotifier<bool>(false);

  //get cropInfoModel12 => null;

  Future<dynamic> loginByNumber(LoginModel loginModel) async {
    var result = await _loginRepository.loginByNumber(loginModel);

    return result;
  }
}
