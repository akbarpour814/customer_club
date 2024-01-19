import 'package:customer_club/configs/di.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class IHomeDataSource {
  Future<Response> getHomeData();
  Future<Response> getGuilds();
  Future<Response> getGuildDetails(int guildId);
  Future<Response> getLocationShops();
  Future<Response> getShopDetails(int shopId);
  Future<Response> getDiscountList(int shopId);
  Future<Response> getShopLocation(int shopId);
  Future<Response> getShopWithQr(String qr);
  Future<Response> searchShops(String query);
}

@Injectable(
  as: IHomeDataSource,
)
class HomeDataSource implements IHomeDataSource {
  @override
  Future<Response> getHomeData() => getIt<Dio>().get('home.php');

  @override
  Future<Response> getGuilds() => getIt<Dio>().get('shop_catagories.php');

  @override
  Future<Response> getGuildDetails(int guildId) =>
      getIt<Dio>().get('category_shops.php?shop_catagories_id=$guildId');

  @override
  Future<Response> getLocationShops() => getIt<Dio>().get('shops_location.php');

  @override
  Future<Response> getShopDetails(int shopId) =>
      getIt<Dio>().get('shop.php?shop_id=$shopId');

  @override
  Future<Response> getDiscountList(int shopId) =>
      getIt<Dio>().get('shop_offer.php?shop_id=$shopId');

  @override
  Future<Response> getShopLocation(int shopId) =>
      getIt<Dio>().get('shop_location.php?shop_id=$shopId');

  @override
  Future<Response> getShopWithQr(String qr) =>
      getIt<Dio>().get('qr_shop.php?qrcode=$qr');

  @override
  Future<Response> searchShops(String query) =>
      getIt<Dio>().get('search_shops.php?search=$query');
}
