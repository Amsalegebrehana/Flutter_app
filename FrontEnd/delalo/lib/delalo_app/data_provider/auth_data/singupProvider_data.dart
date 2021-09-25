import 'dart:convert';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupProviderDataProvider {
  final _baseUrl = "10.0.2.2:3000";
  final http.Client httpClient;
  static late SharedPreferences SESSION;

  SignupProviderDataProvider({required this.httpClient}) {
    getSharedPrefernce();
  }

  static Future getSharedPrefernce() async {
    WidgetsFlutterBinding.ensureInitialized();
    SESSION = await SharedPreferences.getInstance();
  }

  Future<void> signupProvider(SignupProvider signup) async {
    final URL = Uri.http(_baseUrl, "/provider");

    try {
      final response = await httpClient.post(URL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'email': signup.email,
            'password': signup.password,
            'firstname': signup.firstname,
            'lastname': signup.lastname,
            'address': signup.address,
            'phone': signup.phone,
            'image': signup.image,
            'role': signup.role,
            'description': signup.description,
            'category': signup.category,
            'jobs_done': 0,
            'per_hour_wage': signup.perHourWage,
            'recommendation': signup.recommendation,
            'average_rating': 0
          }));

      if (response.statusCode == 200) {
        var signedUpProvider = UserStore.fromJson(jsonDecode(response.body));

        print(signedUpProvider.role);
        await SESSION.setString("email", signup.email);
        await SESSION.setString('id', signedUpProvider.id);
        await SESSION.setString("role", signedUpProvider.role);
        await SESSION.setString("token", signedUpProvider.token);

        return;
      } else if (response.statusCode == 400) {
        throw SignupProviderFailedException(errorText: response.body);
      } else {
        throw SignupProviderFailedException(
            errorText: "Connection error. Please try again!");
      }
    } catch (e) {
      throw SignupProviderFailedException(
          errorText: "Connection error. Please try again!");
    }
  }

  Future<List<String>> getCategoriesList() async {
    final URL = Uri.http(_baseUrl, "/category");

    try {
      final response = await httpClient.get(URL, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        final Iterable categories = jsonDecode(response.body);
        List<String> mappedCategoriesNames = List<String>.from(categories
                .map((category) => Category.fromJson(category).name.toString()))
            .toList();
        return mappedCategoriesNames;
      } else if (response.statusCode == 400) {
        throw SignupProviderFailedException(errorText: response.body);
      } else {
        throw SignupProviderFailedException(
            errorText: "Connection error. Please try again!");
      }
    } catch (e) {
      throw SignupProviderFailedException(
      errorText: "Connection error. Please try again! ee");
    }
  }
}
