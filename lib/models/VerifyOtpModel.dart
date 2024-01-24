class VerifyOtpModel {
  int? enteredOtp;
  String? phoneNumber;

  VerifyOtpModel({this.enteredOtp, this.phoneNumber});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    enteredOtp = json['enteredOtp'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enteredOtp'] = this.enteredOtp;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
