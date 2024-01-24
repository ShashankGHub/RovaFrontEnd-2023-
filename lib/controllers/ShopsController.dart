import 'package:flutter/material.dart';
import 'package:rova_23/models/ShopsModel.dart';
import 'package:rova_23/repositories/ShopsRepository.dart';

class ShopsController {
  ShopsModel shopsModel = ShopsModel();
  ShopsRepository _shopRepository = ShopsRepository();
  final ValueNotifier<bool> isLoadingState = ValueNotifier<bool>(false);

  Future<dynamic> getShopDetails(ShopsModel shopsModel) async {
    var res = await _shopRepository.getShopDetails(shopsModel);
    return res;
  }
}
