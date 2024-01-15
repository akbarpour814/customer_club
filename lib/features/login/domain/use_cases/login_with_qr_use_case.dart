import 'package:customer_club/configs/gen/di/di.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/core/utils/use_case.dart';
import 'package:customer_club/features/login/domain/repository/login_repository.dart';

class LoginWithQRUseCase extends TPUseCase<DataState<String>, String> {
  @override
  Future<DataState<String>> call(param) =>
      getIt<ILoginRepository>().loginWithQR(param);
}
