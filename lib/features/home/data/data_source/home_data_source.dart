import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class IHomeDataSource{
  Future<Response> getAppConfig();
}

@Injectable(
  as: IHomeDataSource,
)
class HomeDataSource implements IHomeDataSource{
  @override
  Future<Response> getAppConfig() {
    // TODO: implement getAppConfig
    throw UnimplementedError();
  }
}