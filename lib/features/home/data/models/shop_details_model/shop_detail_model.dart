import 'shop_gallery_model.dart';

class ShopModel {
  int? id;
  String? name;
  String? aboutUs;
  String? manager;
  String? worktime;
  int? view;
  String? city;
  List<Map<String, dynamic>>? contentCat;
  int? rating;
  int? follow;
  String? shopImg;
  String? shopBg;
  List<ShopGalleryModel>? shopGallery;

  ShopModel({
    this.id,
    this.name,
    this.aboutUs,
    this.manager,
    this.worktime,
    this.view,
    this.city,
    this.contentCat,
    this.rating,
    this.follow,
    this.shopImg,
    this.shopBg,
    this.shopGallery,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        aboutUs: json['about_us'] as String?,
        manager: json['manager'] as String?,
        worktime: json['worktime'] as String?,
        view: json['view'] as int?,
        city: json['city'] as String?,
        contentCat: (json['content_cat'] as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList(),
        rating: json['rating'] as int?,
        follow: json['follow'] as int?,
        shopImg: json['shop_img'] as String?,
        shopBg: json['shop_bg'] as String?,
        shopGallery: (json['shop_gallery'] as List<dynamic>?)
            ?.map((e) => ShopGalleryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'about_us': aboutUs,
        'manager': manager,
        'worktime': worktime,
        'view': view,
        'city': city,
        'content_cat': contentCat,
        'rating': rating,
        'follow': follow,
        'shop_img': shopImg,
        'shop_bg': shopBg,
        'shop_gallery': shopGallery?.map((e) => e.toJson()).toList(),
      };
}
