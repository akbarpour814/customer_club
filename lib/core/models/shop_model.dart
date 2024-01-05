class ShopModel {
  int? id;
  String? name;
  String? shopImg;
  String? shopBg;

  ShopModel({this.id, this.name, this.shopImg, this.shopBg});

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        shopImg: json['shop_img'] as String?,
        shopBg: json['shop_bg'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'shop_img': shopImg,
        'shop_bg': shopBg,
      };
}
