import 'package:rova_23/models/LoginModel.dart';
import 'package:rova_23/utlis/services/rest_api_services.dart';

class LoginRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> loginByNumber(LoginModel loginModel) async {
    final response = await _helper.loginByNumber(loginModel);
    return response;
  }
}
