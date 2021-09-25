part of 'provider_profile_bloc.dart';

@immutable
abstract class ProviderProfileState {}

class ProviderProfileInitial extends ProviderProfileState {}

class ProviderInfoLoading extends ProviderProfileState {}

class ProviderInfoLoadSuccess extends ProviderProfileState {
  final provider;
  final bool isRequested;

  ProviderInfoLoadSuccess(this.provider, this.isRequested);
}

class ProviderInfoLoadFailure extends ProviderProfileState {}
