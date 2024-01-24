class ShopsModel {
  String? city;

  ShopsModel({this.city});

  ShopsModel.fromJson(Map<String, dynamic> json) {
    city = json['City'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['City'] = this.city;
    return data;
  }
}
