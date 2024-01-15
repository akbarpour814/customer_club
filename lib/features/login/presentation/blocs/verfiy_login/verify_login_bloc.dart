import 'package:bloc/bloc.dart';
import 'package:customer_club/configs/gen/di/di.dart';
import 'package:customer_club/core/utils/data_states.dart';
import 'package:customer_club/features/login/data/models/login_with_qr_request_model.dart';
import 'package:customer_club/features/login/domain/use_cases/login_with_qr_verify_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'verify_login_event.dart';
part 'verify_login_state.dart';

class VerifyLoginBloc extends Bloc<VerifyLoginEvent, VerifyLoginState> {
  VerifyLoginBloc() : super(VerifyLoginInitial()) {
    on<VerifyLoginEvent>((event, emit) async {
      if (event is VerifyLoginRequestEvent) {
        emit(VerifyLoginLoading());
        final state = await LoginWithQRVerifyUseCase().call(event.requestModel);
        if (state is DataSuccess) {
          await getIt<FlutterSecureStorage>()
              .write(key: 'token', value: state.data!);
          emit(VerifyLoginSuccess(token: state.data!));
        } else {
          emit(VerifyLoginError(message: state.error!));
        }
      }
    });
  }
}
