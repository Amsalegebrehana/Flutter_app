
import 'package:delalo/delalo_app/data_provider/auth_data/singupUser_data.dart';
import 'package:delalo/delalo_app/models/models.dart';



class SignupUserRepository {
  final SignupUserDataProvider dataProvider;

  SignupUserRepository({required this.dataProvider});

  Future<void> signup(SignupUser signup) async {
    await dataProvider.signupUser(signup);
  }
}
