part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String role;

  LoginSuccess(this.role);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}
