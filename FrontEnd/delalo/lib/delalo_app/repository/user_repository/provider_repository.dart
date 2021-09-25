import 'package:meta/meta.dart';
import '../../models/models.dart';
import 'package:delalo/delalo_app/data_provider/user_data/category_data.dart';
import 'package:delalo/delalo_app/data_provider/user_data/provider_data.dart';

class ProviderRepository {
  final UserDataProvider dataProvider;

  ProviderRepository({required this.dataProvider})
      : assert(dataProvider != null);

  Future<List<User>> getProviders() async {
    return await dataProvider.getProviders();
  }
  Future<List<User>> getProvidersAll() async {
    return await dataProvider.getProvidersAll();
  }
  Future<List<User>> updateProvider() async {
    return await dataProvider.getProviders();
  }
  Future<List<User>> deleteProvider() async {
    return await dataProvider.getProviders();
  }
}
