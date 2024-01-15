class LoginWithQrRequestModel {
  String? cvv2;
  String? idcard;
  String? username;
  String? fname;
  String? lname;
  String? mobile;

  LoginWithQrRequestModel({
    this.cvv2,
    this.idcard,
    this.username,
    this.fname,
    this.lname,
    this.mobile,
  });

  factory LoginWithQrRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginWithQrRequestModel(
      cvv2: json['cvv2'] as String?,
      idcard: json['idcard'] as String?,
      username: json['username'] as String?,
      fname: json['fname'] as String?,
      lname: json['lname'] as String?,
      mobile: json['mobile'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'cvv2': cvv2,
        'idcard': idcard,
        'username': username,
        'fname': fname,
        'lname': lname,
        'mobile': mobile,
      };
}
