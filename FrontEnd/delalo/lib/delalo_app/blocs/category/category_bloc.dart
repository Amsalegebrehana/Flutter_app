import 'package:delalo/delalo_app/blocs/category/category_bloc.dart';
import 'package:delalo/delalo_app/blocs/category/category_event.dart';
import 'package:delalo/delalo_app/blocs/category/category_state.dart';
import 'package:delalo/delalo_app/repository/user_repository/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository})
      : 
        super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoriesLoad) {
      yield CategoryLoading();
      try {
        final categories = await categoryRepository.getCategories();

        yield CategoriesLoadSuccess(categories);
      } catch (error) {
        print(error);
        yield CategoryOperationFailure();
      }
    }
  }
}
