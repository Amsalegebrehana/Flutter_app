import 'package:equatable/equatable.dart';

abstract class ProviderEvent extends Equatable {
  const ProviderEvent();
}

class LoadAllProviders extends ProviderEvent {
  const LoadAllProviders();
  @override
  // TO DO: implement props
  List<Object> get props => [];
}

