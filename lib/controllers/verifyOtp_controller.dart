import 'package:flutter/material.dart';
import 'package:rova_23/models/VerifyOtpModel.dart';
import 'package:rova_23/repositories/verifyOtp_repository.dart';

class VerifyOtpController {
  final ValueNotifier<bool> isLoadingState = ValueNotifier<bool>(false);

  //get cropInfoModel12 => null;
  VerifyOtpRepository _verifyOtpRepository = VerifyOtpRepository();
  Future<dynamic> verifyOtp(VerifyOtpModel verifyOtpModel) async {
    var result = await _verifyOtpRepository.verifyOtp(verifyOtpModel);
    return result;
  }
}
