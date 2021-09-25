import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object> get props => [];
  
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<dynamic> catagories;
  CategoryLoaded([this.catagories = const []]);
  @override
  List<Object> get props => [catagories];
}

class CategoryNavigate extends CategoryState {}
class CategoryOperationFailed extends CategoryState {}
