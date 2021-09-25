import 'package:delalo/delalo_app/data_provider/user_data/provider_list_data.dart';
import 'package:delalo/delalo_app/models/user.dart';

class ProviderListRepository{
  final ProviderListDataProvider providerListDataProvider;
  ProviderListRepository({required this.providerListDataProvider});

  Future<List<User>> getProviderList(String category) async{
      return await providerListDataProvider.getProviderList(category);
  }
}