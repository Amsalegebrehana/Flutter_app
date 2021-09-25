import 'package:equatable/equatable.dart';

abstract class ProviderListEvent extends Equatable{
  const ProviderListEvent();
  
}

class ProviderListLoad extends ProviderListEvent{
  final String category;
  ProviderListLoad({required this.category});
  @override
  List<Object?> get props => [];
  
}