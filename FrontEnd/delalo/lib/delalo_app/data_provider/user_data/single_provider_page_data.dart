import 'dart:convert';

import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/delalo_app/models/orderDetailsReview.dart';
import 'package:delalo/delalo_app/models/provider_isHired.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProviderProfileDataProvider {
  final http.Client httpClient;

  ProviderProfileDataProvider({required this.httpClient});

  Future<ProviderIsHired> getProvider(
      String providerId, String seekerId) async {
    final URL = Uri.http("10.0.2.2:3000", "/provider/$providerId");
    final response = await httpClient.get(
      URL,
      headers: <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final secondResponse = await httpClient.get(
      Uri.http("10.0.2.2:3000", "/order/$providerId/$seekerId"),
      headers: <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200 && secondResponse.statusCode == 200) {
      late var isHired;
      final provider = User.fromJson(jsonDecode(response.body));

      isHired = jsonDecode(secondResponse.body)['order'] != "" ? true : false;

      return new ProviderIsHired(provider, isHired);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<List<OrderDetailsReview>> getReviewsOfProvider(
      String providerId) async {
    final URL = Uri.http("10.0.2.2:3000", "/completedJobs/$providerId");

    try {
      final response = await httpClient.get(
        URL,
        headers: <String, String>{
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final ordersOfProvider = jsonDecode(response.body) as List;
        return ordersOfProvider.map((orderdetails) {
          return OrderDetailsReview.fromJson(orderdetails);
        }).toList();
      } else if (response.statusCode == 400) {
        throw LoginFailedException(errorText: 'No Reviews');
      } else {
        throw Exception('Sorry not working');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> createOrder(String providerId) async {
    final URL = Uri.http("10.0.2.2:3000", "/order");

    print(URL);
    // get sharedpreference instance
    await WidgetsFlutterBinding.ensureInitialized();
    final SESSION = await SharedPreferences.getInstance();

    final seekId = await SESSION.getString("id");
    print(seekId);

    try {
      final response = await httpClient.post(URL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'provider_id': providerId,
            'seeker_id': seekId
          }));
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('new debug..1');
        return;
      } else {
        throw Exception('Failed to load reviews');
      }
    } catch (e) {
      Exception(e.toString());
    }
  }
}
