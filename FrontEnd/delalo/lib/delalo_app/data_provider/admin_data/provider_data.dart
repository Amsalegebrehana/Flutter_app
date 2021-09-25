import 'dart:convert';
import 'dart:io';

import 'package:delalo/delalo_app/models/models.dart';
import 'package:http/http.dart' as http;
 
 
class AdminProviderDataProvider {
  final _baseurl = 'http://localhost:3000';
  final http.Client httpClient;
  AdminProviderDataProvider({required this.httpClient})
     ;

  Future<List<User>> getProvidersFromProvider() async {
    try {
      final response =
          await httpClient.get(
            Uri.parse("http://localhost:3000/provider"),
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json; charset=UTF-8',
          });
     
      if (response.statusCode == 200) {
        Iterable providers = jsonDecode(response.body);
     
        List<User> providersmaped = List<User>.from(
            providers.map((provider) => User.fromJson(provider))).toList();
       
        return providersmaped;
      } else {
        throw Exception("Error");
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    }
  }

  Future<List> getProviderFromProvider(String id) async {
    try {
      final response =
          await httpClient.get(Uri.https(_baseurl, "/provider/:$id"));
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
