part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
  final LoginDataModel loginmodel;
  LoginSuccess(this.loginmodel);
}
final class LoginError extends LoginState {
  late final String Error;
  LoginError(this.Error);
}
final class ChangePasswordVisibilityState extends LoginState {}

