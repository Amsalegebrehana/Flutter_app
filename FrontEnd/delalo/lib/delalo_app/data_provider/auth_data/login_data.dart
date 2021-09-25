import 'dart:convert';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataProvider {
  final _baseUrl = "localhost:3000";
  final http.Client httpClient;
  static late SharedPreferences SESSION;

  // final URL = Uri.parse('http://10.6.201.36:3000/login');

  LoginDataProvider({required this.httpClient}) {
    getSharedPrefernce();
  }

  static Future getSharedPrefernce() async {
    WidgetsFlutterBinding.ensureInitialized();
    SESSION = await SharedPreferences.getInstance();
  }

  Uri generateUri(path) {
    return Uri.http(_baseUrl, path);
  }

  Future<String> login(Login login) async {
    final URL = Uri.http("10.0.2.2:3000", "/login");
    // print(login.email);
    // print(login.password);
    // print(URL);

    try {
      final response = await httpClient.post(URL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'email': login.email,
            'password': login.password
          }));
      if (response.statusCode == 200) {
        var toStore = UserStore.fromJson(jsonDecode(response.body));
        await SESSION.setString("email", login.email);
        await SESSION.setString("role", toStore.role);
        await SESSION.setString("token", toStore.token);
        await SESSION.setString('id', toStore.id);

        return toStore.role;
      } else if (response.statusCode == 400) {
        throw LoginFailedException(errorText: response.body);
      } else {
        throw LoginFailedException(
            errorText: "Connection error. Please try again");
      }
    } on LoginFailedException catch (e) {
      throw LoginFailedException(
          errorText: e.toString());
    } catch (e){
      throw LoginFailedException(errorText: "Connection error. Please try again");
    }
  }
}
