import 'package:flutter/material.dart';
import 'package:rova_23/models/Authmodel.dart';
import 'package:rova_23/repositories/auth_repository.dart';

class AuthUserController {
  Authmodel authmodel = Authmodel();
  AuthUserRepository _authUserRepository = AuthUserRepository();
  final ValueNotifier<bool> isLoadingState = ValueNotifier<bool>(false);

  Future<dynamic> generateOtp(Authmodel authmodel) async {
    var res = await _authUserRepository.generateOtp(authmodel);
    return res;
  }
}
