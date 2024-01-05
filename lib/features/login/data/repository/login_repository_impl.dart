import 'package:customer_club/configs/gen/di/di.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/core/utils/extentions.dart';
import 'package:customer_club/features/login/data/data_source/login_data_source.dart';
import 'package:customer_club/features/login/data/models/app_config_model.dart';
import 'package:customer_club/features/login/domain/repository/login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(
  as: ILoginRepository,
)
class LoginRepository implements ILoginRepository {
  @override
  Future<DataState<AppConfigModel>> getAppConfig() async {
    try {
      final res = await getIt<ILoginDataSource>().getAppConfig();
      if (res.validate()) {
        return DataSuccess(AppConfigModel.fromJson((res.data)));
      }
      return DataError(res.getErrorMessage);
    } catch (e) {
      return DataError(null.getErrorMessage);
    }
  }
}
