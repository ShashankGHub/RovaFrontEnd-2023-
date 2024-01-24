import 'package:rova_23/models/CropInfoModel.dart';
import 'package:rova_23/utlis/services/rest_api_services.dart';

class CropRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> getCropInformation(String filename) async {
    final response = await _helper.uploadImageMediaPostRequest(filename);
    return CropInfoModel.fromJson(response);
  }
}
