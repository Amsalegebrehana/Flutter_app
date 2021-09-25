part of 'signupUser_bloc.dart';

@immutable
abstract class SignupUserState{}

class SignupUserInitial extends SignupUserState {}

class SignupUserLoading extends SignupUserState {}

class SignupUserSuccess extends SignupUserState {}

class SignupUserFailure extends SignupUserState {
  final String error;

  SignupUserFailure({required this.error});
}