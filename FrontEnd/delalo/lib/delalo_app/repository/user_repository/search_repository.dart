import 'package:delalo/delalo_app/data_provider/user_data/search_data.dart';
import 'package:delalo/delalo_app/models/category.dart';


class SearchCategoryRepository{
  final SearchCategoryDataProvider searchCategoryDataProvider;
  SearchCategoryRepository({required this.searchCategoryDataProvider});

  Future<List<Category>> getCategories(String query) async{
      return await searchCategoryDataProvider.getCategories(query);
  }
}
