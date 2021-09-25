import 'package:equatable/equatable.dart';
import 'package:delalo/delalo_app/models/models.dart';

class ProviderState extends Equatable {
  const ProviderState();

  @override
  List<Object> get props => [];
}

class ProviderLoading extends ProviderState {}

class ProviderLoadSuccess extends ProviderState {
  final List<dynamic> provider;

  ProviderLoadSuccess([this.provider = const []]);

  @override
  List<Object> get props => [provider];
}

class ProviderOperationFailure extends ProviderState {}
