import 'package:flutter/material.dart';
import 'package:rova_23/models/CropDiseaseInfoModel.dart';

import 'package:rova_23/repositories/CropDiseaseResultRepository.dart';

class CropDiseaseResultController {
  CropDiseaseInfoModel cropDiseaseResultModel = CropDiseaseInfoModel();
  CropDiseaseResultRepository _cropDiseaseResultRepository =
      CropDiseaseResultRepository();
  final ValueNotifier<bool> isLoadingState = ValueNotifier<bool>(false);

  //get cropInfoModel12 => null;

  Future<dynamic> fetchCropDiseaseInfo(String diseaseName) async {
    try {
      isLoadingState.value = true;
      isLoadingState.notifyListeners();

      cropDiseaseResultModel = await _cropDiseaseResultRepository
          .getCropDiseaseInformation(diseaseName);
      isLoadingState.value = false;
      isLoadingState.notifyListeners();
      return cropDiseaseResultModel;
    } catch (err) {
      return err;
    }
  }
}
