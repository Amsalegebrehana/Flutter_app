
import 'package:delalo/delalo_app/data_provider/auth_data/login_data.dart';
import 'package:delalo/delalo_app/models/models.dart';



class LoginRepository {
  final LoginDataProvider dataProvider;

  LoginRepository({required this.dataProvider});

  Future<String> login(Login login) async {
    return await dataProvider.login(login);
  }
}
