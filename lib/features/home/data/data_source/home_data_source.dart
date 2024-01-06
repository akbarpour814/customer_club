import 'package:customer_club/configs/gen/di/di.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class IHomeDataSource {
  Future<Response> getHomeData();
  Future<Response> getGuilds();
}

@Injectable(
  as: IHomeDataSource,
)
class HomeDataSource implements IHomeDataSource {
  @override
  Future<Response> getHomeData() => getIt<Dio>().get('home.php');
  
  @override
  Future<Response> getGuilds() => getIt<Dio>().get('shop_catagories.php');
}
