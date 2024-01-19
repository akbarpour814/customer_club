class UserModel {
  String? username;
  String? fname;
  String? lname;
  String? email;
  String? mobile;
  String? image;
  String? city;
  int? cityId;
  int? idcard;
  bool? qrscan;
  int? shopId;
  String? shopName;

  UserModel({
    this.username,
    this.fname,
    this.lname,
    this.email,
    this.mobile,
    this.image,
    this.city,
    this.cityId,
    this.idcard,
    this.qrscan,
    this.shopId,
    this.shopName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json['username'] as String?,
        fname: json['fname'] as String?,
        lname: json['lname'] as String?,
        email: json['email'] as String?,
        mobile: json['mobile'] as String?,
        image: json['image'] as String?,
        city: json['city'] as String?,
        cityId: json['city_id'] as int?,
        idcard: json['idcard'] as int?,
        qrscan: json['qrscan'] as bool?,
        shopId: json['shop_id'] as int?,
        shopName: json['shop_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'fname': fname,
        'lname': lname,
        'email': email,
        'mobile': mobile,
        'image': image,
        'city': city,
        'city_id': cityId,
        'idcard': idcard,
        'qrscan': qrscan,
        'shop_id': shopId,
        'shop_name': shopName,
      };
}
