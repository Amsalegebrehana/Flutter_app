import 'dart:convert';
import 'dart:io';

import 'package:delalo/delalo_app/models/category.dart';

import 'package:http/http.dart' as http;

class AdminCategoryDataProvider {
  final _baseUrl = "127.0.0.1:3000";
  final http.Client httpClient;

  Uri generateUri(path) {
    return Uri.http(_baseUrl, path);
  }

  AdminCategoryDataProvider({required this.httpClient});

  // creating a category or posting
  // final response =  httpClient.post(Uri.parse("http://127.0.0.1:3000/category");
  // print("this is status ${response.statusCode} on category data provider ${response.body}");

  Future<void> createCategory(Category category) async {
    try {
      final response =
          await httpClient.post(Uri.parse("http://localhost:3000/category"),
              headers: <String, String>{
                'Accept': 'application/json',
                'Access-Control-Allow-Origin': '*',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                'id': category.id,
                'name': category.name,
                'image': category.image,
                'numOfProviders': category.numOfProviders,
                'description': category.description
              }));
     

      if (response.statusCode == 201) {
        print(response.statusCode);
        return;
      } else {
        throw Exception("Error");
      }
    } on SocketException catch (e) {
      
      throw e;
    } on HttpException catch (e) {
     
      throw e;
    }
  }

  // get categories
  Future<List<Category>> getCategoriesFromCategory() async {
    try {
      final response = await httpClient.get(
          Uri.parse("http://localhost:3000/category"),
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json; charset=UTF-8',
          });
      // print("this is in data provider");

      if (response.statusCode == 200) {
        Iterable categories = jsonDecode(response.body);
      
        List<Category> categoriesmaped = List<Category>.from(
            categories.map((category) => Category.fromJson(category))).toList();

        
        return categoriesmaped;
        //  categories
        //     .map((category) => Category.fromJson(category))
        //     .toList();
      } else {
        throw Exception("Failed to load Categories");
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
     
      final response = await httpClient.delete(
          Uri.parse("http://localhost:3000/category/$id"),
          headers: <String, String>{
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json; charset=UTF-8',
          });
     
      if (response.statusCode != 200) {
        print("new debug...2");
        throw Exception("Error deleting Category");
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      final response = await httpClient.put(
        Uri.parse("http://localhost:3000/category/${category.id}"),
        headers: <String, String>{
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': category.id,
          'name': category.name,
          'image': category.image,
          'numOfProviders': category.numOfProviders,
          'description': category.description
        }),
      );
      
      if (response.statusCode != 200) {
        throw Exception('Error Updating category');
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    }
  }
}
