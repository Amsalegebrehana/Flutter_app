import 'dart:convert';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/delalo_app/models/userOnly.dart';
import 'package:delalo/delalo_app/models/user_only.dart';

import 'package:http/http.dart' as http;

class UserOnlyDataProvider {
  final _baseUrl = "http://10.5.220.129:3000";
  final http.Client httpClient;

  UserOnlyDataProvider({required this.httpClient});

  Uri generateUri(path) {
    return Uri.http(_baseUrl, path);
  }

  Future<Users> createUser(Users userOnly) async {
    final response = await httpClient.post(Uri(path: '$_baseUrl/UserOnly'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "firstname": userOnly.firstname,
          "lastname": userOnly.lastname,
          'address': userOnly.address,
          'provider_id': userOnly.email,
          'role': userOnly.role,
          // 'image': userOnly.image,
          'password': userOnly.password,
          'phone': userOnly.phone,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return Users.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create User.');
    }
  }

  Future<Users> updateUser(dynamic userOnly) async {
    final response = await httpClient.patch(Uri(path: '$_baseUrl/UserOnly'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          "firstname": userOnly.firstname,
          "lastname": userOnly.lastname,
          'address': userOnly.address,
          'provider_id': userOnly.email,
          'role': userOnly.role,
          'image': userOnly.image,
          'password': userOnly.password,
          'phone': userOnly.phone,
        }));

    if (response.statusCode == 201) {
      return Users.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update User.');
    }
  }

  // Future<List<Users>> getUsers() async {
  //   final response = await httpClient.get(
  //     generateUri('UserOnly'),
  //     headers: <String, String>{
  //       'Accept': 'application/json',
  //       'Access-Control-Allow-Origin': '*',
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     Iterable Users = jsonDecode(response.body);

  //     List<Users> mappedUsers =
  //         List<Users>.from(Users.map((user) => Users.fromJson(user))).toList();

  //     return mappedUsers;
  //   } else {
  //     throw Exception('Failed to load UserOnlys');
  //   }
  // }

  Future<List<Users>> getUserByEmail(String email) async {
    // final response =
    //     await httpClient.get(Uri(path: '$_baseUrl/users/byEmail/${email}'));
    final response = await http
        .get(Uri.parse('http://10.5.220.129:3000/users/byEmail/${email}'));

    if (response.statusCode == 200) {
      print(response.body);
      final users = jsonDecode(response.body) as List;
      print(users);
      return users.map((user) => Users.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load UserOnly by Email');
    }
  }

  Future<void> deleteUser(Users userOnly) async {
    final http.Response response = await httpClient.delete(
      Uri(path: '$_baseUrl/users/${userOnly.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user.');
    }
  }
}
