import 'package:customer_club/core/models/shop_model.dart';

class HomeDataModel {
  List<ShopModel>? shops;
  List<String>? slides;

  HomeDataModel({this.shops, this.slides});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        shops: (json['shops'] as List<dynamic>?)
            ?.map((e) => ShopModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        slides: (json['slides'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'shops': shops?.map((e) => e.toJson()).toList(),
        'slides': slides,
      };
}
