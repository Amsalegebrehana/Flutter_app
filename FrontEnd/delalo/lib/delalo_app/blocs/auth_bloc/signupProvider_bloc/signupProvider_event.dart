part of 'signupProvider_bloc.dart';

@immutable
abstract class SignupProviderEvent {}

class SignupProviderFormSubmitted extends SignupProviderEvent {
  final String firstname;
  final String lastname;
  final String role;
  final String email;
  final String password;
  final String phone;
  final String image;
  final String address;
  final String description;
  final String category;
  final String recommendation;
  final int perHourWage;

  SignupProviderFormSubmitted(
      {required this.email,
      required this.password,
      required this.firstname,
      required this.lastname,
      required this.role,
      required this.phone,
      required this.image,
      required this.address,
      required this.description,
      required this.category,
      required this.recommendation,
      required this.perHourWage});
}

class LoadProviderSignup extends SignupProviderEvent {}
