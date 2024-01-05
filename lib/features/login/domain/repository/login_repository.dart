import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/features/login/data/models/app_config_model.dart';

abstract class ILoginRepository {
  Future<DataState<AppConfigModel>> getAppConfig();
}
