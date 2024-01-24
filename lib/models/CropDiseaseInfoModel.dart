class CropDiseaseInfoModel {
  Data? data;
  bool? success;
  Null? errorMessage;
  String? resultMessage;
  Null? errorCode;

  CropDiseaseInfoModel(
      {this.data,
      this.success,
      this.errorMessage,
      this.resultMessage,
      this.errorCode});

  CropDiseaseInfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    errorMessage = json['errorMessage'];
    resultMessage = json['resultMessage'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['errorMessage'] = this.errorMessage;
    data['resultMessage'] = this.resultMessage;
    data['errorCode'] = this.errorCode;
    return data;
  }
}

class Data {
  int? id;
  String? cropName;
  String? cropDiseaseName;
  List<String>? symptoms;
  List<String>? solutions;
  String? modelName;

  Data(
      {this.id,
      this.cropName,
      this.cropDiseaseName,
      this.symptoms,
      this.solutions,
      this.modelName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cropName = json['cropName'];
    cropDiseaseName = json['cropDiseaseName'];
    symptoms = json['symptoms'].cast<String>();
    solutions = json['solutions'].cast<String>();
    modelName = json['modelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cropName'] = this.cropName;
    data['cropDiseaseName'] = this.cropDiseaseName;
    data['symptoms'] = this.symptoms;
    data['solutions'] = this.solutions;
    data['modelName'] = this.modelName;
    return data;
  }
}
