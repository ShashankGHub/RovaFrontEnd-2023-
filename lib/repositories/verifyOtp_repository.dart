import 'package:rova_23/models/VerifyOtpModel.dart';
import 'package:rova_23/utlis/services/rest_api_services.dart';

class VerifyOtpRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> verifyOtp(VerifyOtpModel verifyOtpModel) async {
    var response = await _helper.verifyOtp(verifyOtpModel);
    return response;
  }
}
