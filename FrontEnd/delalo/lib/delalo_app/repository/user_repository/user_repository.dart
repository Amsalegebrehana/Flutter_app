import 'package:meta/meta.dart';
// import 'package:/delalo/delalo_app/models/userOnly.dart';
import '../../models/userOnly.dart';
import '../../models/user_only.dart';
import '../../data_provider/user_data/user_data.dart';
// import 'delalo/delalo_app/data_provider/user_data/user_data.dart';

class UserRepository {
  final UserOnlyDataProvider dataProvider;

  UserRepository({required this.dataProvider}) : assert(dataProvider != null);

  // Future<List<Users>> getUsers() async {
  //   return await dataProvider.getUsers();
  // }

  Future<List<Users>> getUserByEmail(String email) async {
    print(email);
    return await dataProvider.getUserByEmail(email);
  }

  Future<void> updateUser(dynamic userOnly) async {
    await dataProvider.updateUser(userOnly);
  }

  Future<void> deleteUser(dynamic userOnly) async {
    await dataProvider.deleteUser(userOnly);
  }
}
