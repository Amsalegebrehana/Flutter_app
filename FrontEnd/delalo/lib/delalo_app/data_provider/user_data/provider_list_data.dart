import 'dart:convert';
import 'dart:io';

import 'package:delalo/delalo_app/exports.dart';
import 'package:delalo/delalo_app/models/user.dart';
import 'package:http/http.dart' as http;

class ProviderListDataProvider {
  final _baseurl = '10.0.2.2:3000';
  final http.Client httpClient;

  ProviderListDataProvider({required this.httpClient});

  Future<List<User>> getProviderList(String category) async {
    try {
      print("hey");
      print(category);
      final response =
          await httpClient.get(Uri.http(_baseurl, "/providers/$category"));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final providers = jsonDecode(response.body) as List;
        print('debug...');
        List<User> mappedProviders =
            providers.map((provider) => User.fromJson(provider)).toList();

        print(mappedProviders);
        return mappedProviders;
      } else {
        throw Exception("Error");
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    }
  }
}
