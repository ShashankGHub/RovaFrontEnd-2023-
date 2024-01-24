import 'package:rova_23/models/crop_info_model12.dart';
import 'package:rova_23/utlis/services/rest_api_services1.dart';

class CropRepository1 {
  ApiModelNameHelper _apiModelNameHelper = ApiModelNameHelper();

  Future<dynamic> getCropInformation(String modelName) async {
    try {
      var cropDetailsResponse =
          await _apiModelNameHelper.getModelName(modelName);

      String obtainedModelName = cropDetailsResponse['data'][0]['modelName'];

      return CropInfoModel12.fromJson(cropDetailsResponse);
    } catch (err) {
      return err;
    }
  }
}
