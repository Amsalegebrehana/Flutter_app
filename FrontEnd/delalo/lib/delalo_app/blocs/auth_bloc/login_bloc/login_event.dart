part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginFormSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginFormSubmitted({required this.email, required this.password});
}

