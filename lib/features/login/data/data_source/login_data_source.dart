import 'package:customer_club/configs/gen/di/di.dart';
import 'package:customer_club/features/login/data/models/login_with_qr_request_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class ILoginDataSource {
  Future<Response> getAppConfig();
  Future<Response> loginWithQR(String qr);
  Future<Response> loginWithQRVerify(LoginWithQrRequestModel requestModel);
}

@Injectable(
  as: ILoginDataSource,
)
class LoginDataSource implements ILoginDataSource {
  @override
  Future<Response> getAppConfig() => getIt<Dio>().get('config_api.php');

  @override
  Future<Response> loginWithQR(String qr) =>
      getIt<Dio>().post('register_step1_qr.php', data: {'qrcode': qr});

  @override
  Future<Response> loginWithQRVerify(LoginWithQrRequestModel requestModel) =>
      getIt<Dio>().post('register_step2_cvv.php', data: requestModel.toJson());
}
