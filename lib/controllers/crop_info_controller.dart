import 'package:flutter/material.dart';
import 'package:rova_23/models/CropInfoModel.dart';
import 'package:rova_23/repositories/crop_repository.dart';

class CropInfoController {
  CropInfoModel cropInfoModel = CropInfoModel();
  CropRepository _cropRepository = CropRepository();
  final ValueNotifier<bool> isLoadingState = ValueNotifier<bool>(false);

  //get cropInfoModel12 => null;

  Future<dynamic> fetchCropInfo(String filename) async {
    try {
      cropInfoModel = await _cropRepository.getCropInformation(filename);
      isLoadingState.value = false;
      isLoadingState.notifyListeners();
      return cropInfoModel;
    } catch (err) {
      return err;
    }
  }
}
