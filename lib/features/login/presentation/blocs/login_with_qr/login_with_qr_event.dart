part of 'login_with_qr_bloc.dart';

@immutable
sealed class LoginWithQrEvent {}

class LoginWithQrRequestEvent extends LoginWithQrEvent {
  final String qr;

  LoginWithQrRequestEvent({required this.qr});
}

class InqueryVirtualCardTokenEvent extends LoginWithQrEvent {
  final String token;

  InqueryVirtualCardTokenEvent({required this.token});
}
