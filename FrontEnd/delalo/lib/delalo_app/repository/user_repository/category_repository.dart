import 'package:meta/meta.dart';
import '../../models/models.dart';
import 'package:delalo/delalo_app/data_provider/user_data/category_data.dart';

class CategoryRepository {
  final CategoryDataProvider dataProvider;

  CategoryRepository({required this.dataProvider}) ;

  Future<List<Category>> getCategories() async {
    return await dataProvider.getCategories();
  }

 
}
