import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/features/login/data/models/app_config_model.dart';
import 'package:customer_club/features/login/data/models/login_or_register_response_model.dart';
import 'package:customer_club/features/login/data/models/login_with_qr_request_model.dart';

abstract class ILoginRepository {
  Future<DataState<AppConfigModel>> getAppConfig();
  Future<DataState<LoginOrRegisterResponseModel>> loginWithQR(String qr);
  Future<DataState<String>> loginWithQRVerify(LoginWithQrRequestModel requestModel);
}
