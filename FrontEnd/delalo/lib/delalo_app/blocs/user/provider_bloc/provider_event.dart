import 'package:equatable/equatable.dart';
import 'package:delalo/delalo_app/models/models.dart';

abstract class ProviderEvent extends Equatable {
  const ProviderEvent();
}

class ProviderLoad extends ProviderEvent {
  const ProviderLoad();
  
  @override
  List<Object> get props => [];
}

class ProviderUpdate extends ProviderEvent {
  final User provider;

  const ProviderUpdate(this.provider);

  @override
  List<Object> get props => [provider];

  @override
  String toString() => 'Provider Updated {Provider: $provider}';
}

class ProviderDelete extends ProviderEvent {
  final User provider;

  const ProviderDelete(this.provider);

  @override
  List<Object> get props => [provider];

  @override
  toString() => 'Provider Deleted {Provider: $provider}';
}
