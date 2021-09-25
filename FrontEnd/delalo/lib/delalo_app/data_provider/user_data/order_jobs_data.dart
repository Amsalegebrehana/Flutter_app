import 'dart:convert';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/delalo_app/models/orderDetailsReview.dart';

import 'package:http/http.dart' as http;

class OrderDataProvider {
  final _baseUrl = "10.5.228.139:3000";
  final http.Client httpClient;

  Uri generateUri(path) {
    return Uri.http(_baseUrl, path);
  }

  OrderDataProvider({required this.httpClient});
  Future<Order> createOrder(Order order) async {
    final response = await httpClient.post(
      Uri(path: '$_baseUrl/order'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'seeker_id': order.seeker_id,
        'provider_id': order.provider_id,
      }),
    );

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Order.');
    }
  }

  Future<List<Order>> getOrders() async {
    final response = await httpClient.get(
      generateUri('order'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Iterable orders = jsonDecode(response.body);

      List<Order> mappedOrders =
          List<Order>.from(orders.map((order) => Order.fromJson(order)))
              .toList();

      return mappedOrders;
    } else {
      throw Exception('Failed to load Orders');
    }
  }

  Future<Order> getOrderById(String seeker_id) async {
    final response =
        await httpClient.get(Uri(path: '$_baseUrl/order/${seeker_id}'));

    if (response.statusCode == 200) {
      final order = jsonDecode(response.body);
      return Order.fromJson(order);
    } else {
      throw Exception('Failed to load order by Id');
    }
  }

  Future<dynamic> deleteOrder(String order_id) async {
    final response = await httpClient.delete(
      generateUri('order/${order_id}'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete Order.');
    }
    return response.statusCode;
  }

  Future<void> updateOrder(String order_id, String progress) async {
    final response = await httpClient.put(
      generateUri('order/${order_id}'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'progress': progress,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update order progress.');
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

  Future<dynamic> updateJobStatus(String order_id, String status) async {
    final response = await httpClient.put(
      generateUri('updateStatus/${order_id}'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'status': status,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update job status.');
    }
    return response.statusCode;
  }

  Future<dynamic> getActiveJob(String provider_id) async {
    try {
      final response = await httpClient.get(
          generateUri('activeJob/${provider_id}'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        final job = jsonDecode(response.body);
        return OrderDetails.fromJson(job[0]);
      } else if (response.statusCode == 400) {
        return "No Active Job";
      } else {
        throw Exception('Failed to load job by provider Id');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getPendingJobs(String provider_id) async {
    try {
      final response = await httpClient.get(
          generateUri('pendingJobs/${provider_id}'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        Iterable jobs = jsonDecode(response.body);
        List<OrderDetails> mappedJobs = List<OrderDetails>.from(
            jobs.map((job) => OrderDetails.fromJson(job))).toList();

        return mappedJobs;
      } else {
        return ["No Pending Jobs"];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getDeclinedJobs(String provider_id) async {
    final response = await httpClient
        .get(Uri(path: '$_baseUrl/declinedJobs/${provider_id}'));

    if (response.statusCode == 200) {
      final jobs = jsonDecode(response.body) as List;
      return jobs.map((job) => OrderDetails.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load declined jobs');
    }
  }

  Future<List<dynamic>> getCompletedJobs(String provider_id) async {
    final response = await httpClient.get(
        generateUri('completedJobs/${provider_id}'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Iterable jobs = jsonDecode(response.body);

      List<OrderDetailsReview> mappedJobs = List<OrderDetailsReview>.from(
          jobs.map((job) => OrderDetailsReview.fromJson(job))).toList();
      return mappedJobs;
    } else {
      return ["No History yet"];
    }
  }

  Future<List<dynamic>> getPendingOrders(String seeker_id) async {
    try {
      final response = await httpClient.get(
          generateUri('pendingOrders/${seeker_id}'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        Iterable jobs = jsonDecode(response.body);

        List<OrderDetails> mappedJobs = List<OrderDetails>.from(
            jobs.map((job) => OrderDetails.fromJson(job))).toList();

        return mappedJobs;
      } else {
        return ["No Pending Orders"];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getDeclinedOrders(String seeker_id) async {
    try {
      final response = await httpClient.get(
          generateUri('declinedOrders/${seeker_id}'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        Iterable jobs = jsonDecode(response.body);

        List<OrderDetails> mappedJobs = List<OrderDetails>.from(
            jobs.map((job) => OrderDetails.fromJson(job))).toList();

        return mappedJobs;
      } else {
        return ["No Declined Orders"];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getActiveOrders(String seeker_id) async {
    try {
      final response = await httpClient.get(
          generateUri('activeOrder/${seeker_id}'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        Iterable orders = jsonDecode(response.body);

        List<OrderDetails> mappedOrders = List<OrderDetails>.from(
            orders.map((order) => OrderDetails.fromJson(order))).toList();

        return mappedOrders;
      } else {
        return ["No Active Orders"];
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getCompletedOrders(String seeker_id) async {
    final response = await httpClient.get(
        generateUri('completedOrders/${seeker_id}'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Iterable orders = jsonDecode(response.body);

      List<OrderDetailsReview> mappedOrders = List<OrderDetailsReview>.from(
          orders.map((order) => OrderDetailsReview.fromJson(order))).toList();
      return mappedOrders;
    } else {
      return ["No History yet"];
    }
  }

  Future<dynamic> getSingleOrder(String order_id) async {
    try {
      final response = await httpClient.get(
          generateUri('singleorder/${order_id}'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        final order = jsonDecode(response.body);

        dynamic mappedDetail = OrderDetails.fromJson(order[0]);

        return mappedDetail;
      } else {
        throw Exception('Failed to load order by order Id');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
