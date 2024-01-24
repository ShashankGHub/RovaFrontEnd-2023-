class CropInfoModel {
  String? type;
  double? accuracy;

  CropInfoModel({this.type, this.accuracy});

  CropInfoModel.fromJson(Map<String, dynamic> json) {
    type = json['class'];
    accuracy = json['accuracy'];
  }

  get modelName => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class'] = this.type;
    data['accuracy'] = this.accuracy;
    return data;
  }
}
