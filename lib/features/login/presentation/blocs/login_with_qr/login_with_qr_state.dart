part of 'login_with_qr_bloc.dart';

@immutable
sealed class LoginWithQrState {}

final class LoginWithQrInitial extends LoginWithQrState {}

final class LoginWithQrLoading extends LoginWithQrState {}

final class LoginWithQrSuccess extends LoginWithQrState {
  final String idCard;

  LoginWithQrSuccess({required this.idCard});
}

final class LoginWithQrError extends LoginWithQrState {
  final String message;

  LoginWithQrError({required this.message});
}
