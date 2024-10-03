import 'package:customer_club/configs/di.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/core/utils/use_case.dart';
import 'package:customer_club/features/login/data/models/login_or_register_response_model.dart';
import 'package:customer_club/features/login/domain/repository/login_repository.dart';

class InqueryVirtualCardTokenUseCase
    extends TPUseCase<DataState<LoginOrRegisterResponseModel>, String> {
  @override
  Future<DataState<LoginOrRegisterResponseModel>> call(param) =>
      getIt<ILoginRepository>().inqueryVirtualCardToken(param);
}
