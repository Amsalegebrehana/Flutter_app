import 'dart:convert';

import 'package:delalo/delalo_app/models/review.dart';
import 'package:http/http.dart' as http;

class ReviewDataProvider {
  final _baseUrl = "10.5.228.139:3000";
  final http.Client httpClient;

  Uri generateUri(path) {
    return Uri.http(_baseUrl, path);
  }

  ReviewDataProvider({required this.httpClient});

  Future<Review> addReview(int rating, String comment, String order_id) async {
    final response = await httpClient.post(generateUri('review'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'rating': rating,
          'comment': comment,
          'order_id': order_id
        }));

    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error");
    }
  }

  Future<List<Review>> getReview() async {
    final response = await httpClient.get(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Iterable reviews = jsonDecode(response.body);
      List<Review> reviewsmapped =
          List<Review>.from(reviews.map((review) => Review.fromJson(review)))
              .toList();
      return reviewsmapped;
    } else {
      throw Exception("Error");
    }
  }
   Future<void> deleteReview(String id) async {
    final response = await httpClient.delete(
      Uri.parse('http://localhost:3000/review/$id'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error");
    } 
  }
  Future<void> updateReview(Review review) async {
    final response = await httpClient.put(Uri.parse(_baseUrl),
        headers: <String, String>{
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': review.id,
          'rating': review.rating,
          'comment': review.comment,
          'order_id': review.order_id
        }));

     if (response.statusCode != 200) {
        throw Exception('Error Updating review');
      }
  }

}
