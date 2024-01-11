import 'package:just_the_tooltip/just_the_tooltip.dart';

class ShopModel {
  int? id;
  int? rating;
  String? name;
  String? shopImg;
  String? shopBg;
  String? manager;
  String? lat;
  String? lng;
  String? address;
  String? create;
  JustTheController? contrller;

  ShopModel(
      {this.id,
      this.name,
      this.shopImg,
      this.shopBg,
      this.rating,
      this.create,
      this.manager,
      this.lat,
      this.lng,
      this.address,
      this.contrller});

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
      id: json['id'] as int?,
      rating: json['rating'] as int?,
      name: json['name'] as String?,
      shopImg: json['shop_img'] as String?,
      shopBg: json['shop_bg'] as String?,
      manager: json['manager'] as String?,
      lat: json['lat'].toString(),
      lng: json['lng'].toString(),
      address: json['address'] as String?,
      create: json['create'] as String?,
      contrller: JustTheController());

  Map<String, dynamic> toJson() => {
        'id': id,
        'rating': rating,
        'name': name,
        'shop_img': shopImg,
        'shop_bg': shopBg,
      };
}
