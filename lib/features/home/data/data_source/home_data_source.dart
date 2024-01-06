import 'package:customer_club/configs/gen/di/di.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class IHomeDataSource {
  Future<Response> getHomeData();
  Future<Response> getGuilds();
  Future<Response> getGuildDetails(int guildId);
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
}
