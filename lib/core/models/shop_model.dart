
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
      this.address});

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
      create: json['create'] as String?);

  Map<String, dynamic> toJson() => {
        'id': id,
        'rating': rating,
        'name': name,
        'shop_img': shopImg,
        'shop_bg': shopBg,
      };
}
