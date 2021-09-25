import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_event.dart';
import 'package:delalo/delalo_app/blocs/admin_bloc/category_bloc/category_state.dart';
import 'package:delalo/delalo_app/repository/admin_repository/admin_category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final AdminCategoryRepository categoryRepository;

  AdminCategoryBloc({required this.categoryRepository})
      : super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    // TO DO: implement mapEventToState
    if (event is LoadAllCategories) {
     
      yield CategoryLoading();
      try {
        final categories = await categoryRepository.getCategoriesFromCategory();
        yield CategoryLoaded(categories);
      } catch (_) {
        yield CategoryOperationFailed();
      }
    }
    if (event is AddCategory) {
      try {
      
        final category = event.category;
       
        await categoryRepository.createCategory(category);
        
        yield CategoryNavigate();
      } catch (_) {
        yield CategoryOperationFailed();
      }
    }
    if (event is CategoryUpdate) {
      try {
        final categoryToUpdate = event.category;
       
        await categoryRepository.updateCategory(categoryToUpdate);
        
        final newcategory =
            await categoryRepository.getCategoriesFromCategory();
        yield CategoryLoaded(newcategory);
      } catch (_) {
        yield CategoryOperationFailed();
      }
    }
    if (event is CategoryDelete) {
      try {
        final categoryId = event.categoryId;
        await categoryRepository.deleteCategory(categoryId);
      
        final newcategory =
            await categoryRepository.getCategoriesFromCategory();
        yield CategoryLoaded(newcategory);
      } catch (_) {
        yield CategoryOperationFailed();
      }
    }
  }
}
