import 'dart:convert';
import 'dart:io';
import 'package:delalo/delalo_app/models/models.dart';

import 'package:http/http.dart' as http;

class CategoryDataProvider {
  final http.Client httpClient;
  final _baseurl= '10.0.2.2:3000';
  // final _baseurl= 'localhost:3000';
  CategoryDataProvider({required this.httpClient});

  Future<List<Category>> getCategories() async {
    
    try {
      // final response =
      //     await http.get(Uri.parse('http://10.5.222.117:3000/category'));
      print("object");
      final response= await httpClient.get(Uri.http(_baseurl,"/category"));
      print(response.statusCode);
      if (response.statusCode == 200) {
        final categories = jsonDecode(response.body) as List;
        print(categories);
        return categories
            .map((category) => Category.fromJson(category))
            .toList();
      } else {
        throw Exception("Error");
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    }
  }

  // Future<Category> getCategoryById(String category_id) async {
  //   final response =
  //       await httpClient.get(Uri(path: '$_baseUrl/Category/${category_id}'));

  //   if (response.statusCode == 200) {
  //     final Category = jsonDecode(response.body);
  //     return Category.fromJson(Category);
  //   } else {
  //     throw Exception('Failed to load Category by Id');
  //   }
  // }
}
