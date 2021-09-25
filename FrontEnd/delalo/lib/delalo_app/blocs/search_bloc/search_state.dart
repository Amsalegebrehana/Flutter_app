import 'package:delalo/delalo_app/models/category.dart';

abstract class SearchState{}

class SearchUninitialized extends SearchState{
  @override
  List<Object> get props =>[];
}

class SearchLoaded extends SearchState{
  List<Category> categories;
  SearchLoaded({required this.categories});
   @override
   List<Object> get props =>[];
}

class SearchError extends SearchState{
   @override
   List<Object> get props => [];
   
}