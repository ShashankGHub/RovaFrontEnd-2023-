import 'package:rova_23/models/CropDiseaseInfoModel.dart';
import 'package:rova_23/utlis/services/rest_api_services.dart';

class CropDiseaseResultRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> getCropDiseaseInformation(String diseaseName) async {
    final response =
        await _helper.get("api/CropInfo/getCropDetails?modelName=$diseaseName");
    return CropDiseaseInfoModel.fromJson(response);
  }
}
