part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

/// Login feito com sucesso, mas o usuário ainda não tem oficina cadastrada.
final class LoginSuccessNeedsShop extends LoginState {}

final class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}
