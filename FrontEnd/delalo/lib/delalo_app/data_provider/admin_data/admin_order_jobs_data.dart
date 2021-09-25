import 'dart:convert';

import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/delalo_app/models/order_jobs.dart';
import 'package:http/http.dart' as http;

class AdminOrderDataProvider {
  final _baseUrl = "localhost:3000";
  final http.Client httpClient;

  Uri generateUri(path) {
    return Uri.http(_baseUrl, path);
  }

  AdminOrderDataProvider({required this.httpClient});
 Future<List<OrderDetails>> getOrders() async {
    final response = await httpClient.get(
      Uri.parse('http://localhost:3000/orderAllCompleted'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
   
    if (response.statusCode == 200) {
      Iterable orders = jsonDecode(response.body) ;
      
      List<OrderDetails> mappedOrders =
          List<OrderDetails>.from(orders.map((order) => OrderDetails.fromJson(order)))
              .toList();

     
      return mappedOrders;
    } else {
      throw Exception('Failed to load Orders');
    }
  }

  Future<List<OrderDetails>> getAllJobs(User provider) async {
    final response =
        await httpClient.get(Uri(path: '$_baseUrl/allJobs/${provider.id}'));

    if (response.statusCode == 200) {
      final jobs = jsonDecode(response.body) as List;
      return jobs.map((job) => OrderDetails.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load all jobs');
    }
  }
}
