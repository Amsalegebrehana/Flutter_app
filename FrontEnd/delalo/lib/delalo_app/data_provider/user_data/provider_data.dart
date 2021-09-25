import 'dart:convert';
import 'dart:io';
import 'package:delalo/delalo_app/models/models.dart';

import 'package:http/http.dart' as http;

class UserDataProvider {
  final http.Client httpClient;

  UserDataProvider({required this.httpClient});
  Future<List<User>> getProvidersAll() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.5.220.129:3000/provider/'));
      if (response.statusCode == 200) {
        final providers = jsonDecode(response.body) as List;
        return providers.map((provider) => User.fromJson(provider)).toList();
      } else {
        throw Exception("Error");
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    }
  }

  Future<List<User>> getProviders() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.5.220.129:3000/provider/top'));
      if (response.statusCode == 200) {
        final providers = jsonDecode(response.body) as List;
        return providers.map((provider) => User.fromJson(provider)).toList();
      } else {
        throw Exception("Error");
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    }
  }

  Future<List<User>> updateProvider() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.5.243.163:3000/provider/top'));
      if (response.statusCode == 200) {
        final providers = jsonDecode(response.body) as List;
        return providers.map((provider) => User.fromJson(provider)).toList();
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
