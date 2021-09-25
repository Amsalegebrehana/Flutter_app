import 'package:delalo/delalo_app/models/models.dart';
import 'package:equatable/equatable.dart';

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoadSuccess extends CategoryState {
  final Category category;

  CategoryLoadSuccess(this.category);

  @override
  List<Object> get props => [category];
}

class CategoriesLoadSuccess extends CategoryState {
  final List<dynamic> categories;

  CategoriesLoadSuccess([this.categories = const []]);

  @override
  List<Object> get props => [categories];
}

class CategoryOperationFailure extends CategoryState {}