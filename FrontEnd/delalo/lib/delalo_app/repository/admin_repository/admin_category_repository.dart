import 'package:delalo/delalo_app/data_provider/admin_data/category_data.dart';
import 'package:delalo/delalo_app/models/category.dart';
import 'package:matcher/src/interfaces.dart';

class AdminCategoryRepository {
  final AdminCategoryDataProvider categoryDataProvider;

  AdminCategoryRepository({required this.categoryDataProvider});

  Future<void> createCategory(Category category) async {
    await categoryDataProvider.createCategory(category);
  }

  Future<List<Category>> getCategoriesFromCategory() async {
    print("This is on category repository file");
    return await categoryDataProvider.getCategoriesFromCategory();
  }

  Future<void> deleteCategory(String id) async {
    await categoryDataProvider.deleteCategory(id);
  }

  Future<void> updateCategory(Category category) async {
     await categoryDataProvider.updateCategory(category);
  }
}
