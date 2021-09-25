import 'package:equatable/equatable.dart';

abstract class ProvidersState extends Equatable {
  const ProvidersState();
    @override
  List<Object> get props => [];
}

class ProviderLoading extends ProvidersState{}
class ProviderLoaded extends ProvidersState{
  final List<dynamic> providers;
  ProviderLoaded([this.providers = const []]);
  @override
  List<Object> get props => [providers];
}

class ProvidersOperationsFailed extends ProvidersState{}
