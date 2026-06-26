part of 'auth_cubit.dart';

sealed class AuthSessionState {}

final class AuthSessionInitial extends AuthSessionState {
  final User? user;
  AuthSessionInitial(this.user);
}

final class AuthSessionLoading extends AuthSessionState {}
