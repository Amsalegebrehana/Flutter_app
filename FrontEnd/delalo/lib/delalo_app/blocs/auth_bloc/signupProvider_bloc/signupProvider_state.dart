part of 'signupProvider_bloc.dart';

@immutable
abstract class SignupProviderState {}

class SingupProviderLoadSuccess extends SignupProviderState {
  final categoryLst;

  SingupProviderLoadSuccess({required this.categoryLst});
}

class SignupProviderInitial extends SignupProviderState {}

class SignupProviderLoading extends SignupProviderState {}

class SignupProviderSuccess extends SignupProviderState {}

class SignupProviderFailure extends SignupProviderState {
  final String error;

  SignupProviderFailure({required this.error});
}
