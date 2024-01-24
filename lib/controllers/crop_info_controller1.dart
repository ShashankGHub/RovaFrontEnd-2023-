import 'package:flutter/material.dart';
import 'package:rova_23/models/crop_info_model12.dart';
import 'package:rova_23/repositories/crop_repository1.dart';

class CropInfoController1 {
  CropInfoModel12 cropInfoModel12 = CropInfoModel12();
  CropRepository1 _cropRepository1 = CropRepository1();
  final ValueNotifier<bool> isLoadingState = ValueNotifier<bool>(false);

  Future<dynamic> fetchCropdetails(String modelName) async {
    try {
      cropInfoModel12 = await _cropRepository1.getCropInformation(modelName);
      isLoadingState.value = false;
      isLoadingState.notifyListeners();
      return cropInfoModel12;
    } catch (err) {
      return err;
    }
  }
}
