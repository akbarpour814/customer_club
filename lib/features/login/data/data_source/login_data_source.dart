import 'package:customer_club/configs/gen/di/di.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class ILoginDataSource {
  Future<Response> getAppConfig();
}

@Injectable(
  as: ILoginDataSource,
)
class LoginDataSource implements ILoginDataSource {
  @override
  Future<Response> getAppConfig() => getIt<Dio>().get('config_api.php');
}
