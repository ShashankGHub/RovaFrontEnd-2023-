class CropInfoModel12 {
  String? cropName;
  String? diseaseName;
  List<String>? symptoms;
  List<String>? solutions;
  String? modelName;

  CropInfoModel12({
    this.cropName,
    this.diseaseName,
    this.modelName,
    this.solutions,
    this.symptoms,
  });

  CropInfoModel12.fromJson(Map<String, dynamic> json) {
    cropName = json['cropName'];
    diseaseName = json['cropDiseaseName'];
    symptoms =
        json['symptoms'] != null ? List<String>.from(json['symptoms']) : null;
    solutions =
        json['solutions'] != null ? List<String>.from(json['solutions']) : null;
    modelName = json['modelName'];
  }

  get type => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cropName'] = cropName;
    data['cropDiseaseName'] = diseaseName;
    data['symptoms'] = symptoms;
    data['solutions'] = solutions;
    data['modelName'] = modelName;
    return data;
  }
}
