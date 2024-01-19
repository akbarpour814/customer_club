import 'package:customer_club/configs/di.dart';
import 'package:customer_club/core/utils/value_notifires.dart';
import 'package:customer_club/features/login/data/models/login_with_qr_request_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class ILoginDataSource {
  Future<Response> getAppConfig();
  Future<Response> loginWithQR(String qr);
  Future<Response> loginWithQRVerify(LoginWithQrRequestModel requestModel);
  Future<Response> registerWithQRVerify(LoginWithQrRequestModel requestModel);
  Future<Response> getAllCity();
  Future<Response> getProfile();
  Future<Response> getShopDetails(int shopId);
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
      getIt<Dio>()
          .post('login_step2_password.php', data: requestModel.toJson());

  @override
  Future<Response> registerWithQRVerify(LoginWithQrRequestModel requestModel) =>
      getIt<Dio>().post('register_step2_cvv.php', data: requestModel.toJson());

  @override
  Future<Response> getShopDetails(int shopId) =>
      getIt<Dio>().get('shop.php?shop_id=$shopId');

  @override
  Future<Response> getAllCity() => getIt<Dio>().get('cities.php');

  @override
  Future<Response> getProfile() =>
      getIt<Dio>().get('user_info.php', data: {'token': tokenNotifire.value});
}
