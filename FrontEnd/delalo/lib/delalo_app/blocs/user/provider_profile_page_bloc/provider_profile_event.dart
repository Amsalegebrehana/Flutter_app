part of 'provider_profile_bloc.dart';

@immutable
abstract class ProviderProfileEvent {}

class LoadProviderInfo extends ProviderProfileEvent {
  final String providerId;
  final String seekerId;

  LoadProviderInfo({required this.providerId, required this.seekerId});
}

class HireButtonPressed extends ProviderProfileEvent {
  final providerId;

  HireButtonPressed({required this.providerId});
}
