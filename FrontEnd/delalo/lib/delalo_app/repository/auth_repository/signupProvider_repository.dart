import 'package:delalo/delalo_app/data_provider/auth_data/singupProvider_data.dart';
import 'package:delalo/delalo_app/models/models.dart';

class SignupProviderRepository {
  final SignupProviderDataProvider dataProvider;

  SignupProviderRepository({required this.dataProvider});

  Future<void> signupProvider(SignupProvider signup) async {
    await dataProvider.signupProvider(signup);
  }

  Future<List<String>> getCategoriesList() async {
    return await dataProvider.getCategoriesList();
  }
}
