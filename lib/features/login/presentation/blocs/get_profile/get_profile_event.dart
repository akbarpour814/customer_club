part of 'get_profile_bloc.dart';

@immutable
sealed class GetProfileEvent {}

class GetProfileStartEvent extends GetProfileEvent {}
