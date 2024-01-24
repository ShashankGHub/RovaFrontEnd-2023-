import 'package:rova_23/models/ShopsModel.dart';
import 'package:rova_23/utlis/services/rest_api_services.dart';

class ShopsRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> getShopDetails(ShopsModel shopsModel) async {
    var response = await _helper.getShopDetails(shopsModel);
    return response;
  }
}
