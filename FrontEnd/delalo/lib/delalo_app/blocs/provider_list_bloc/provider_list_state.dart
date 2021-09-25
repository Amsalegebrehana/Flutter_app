import 'package:equatable/equatable.dart';

abstract class ProviderListState extends Equatable{
  const ProviderListState();
  @override
  List<Object> get props => [];
}

class ProviderListLoading extends ProviderListState{}

class ProviderListLoadSuccess extends ProviderListState{
  final List<dynamic> providers;
  ProviderListLoadSuccess([this.providers = const []]);
}

class ProviderListLoadFail extends ProviderListState{}
