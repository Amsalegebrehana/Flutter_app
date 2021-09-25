import 'dart:convert';
import 'dart:io';
import 'package:delalo/delalo_app/models/category.dart';
import 'package:http/http.dart' as http;


class SearchCategoryDataProvider{
  final _baseurl= '10.5.222.117:3000';
  final http.Client httpClient;

  SearchCategoryDataProvider({required this.httpClient});
      

  Future<List<Category>> getCategories(String query) async {
    try{
      print("9");
      Map<String,String> queryParams={
        'query':query
      };
      String queryString= Uri(queryParameters:queryParams).query;
      String url="?"+queryString;
      print(url);
      // final response= await httpClient.get(Uri.http(_baseurl,'/searchCateogry/$query'));
      final response= await httpClient.get(Uri.http(_baseurl,"/searchCategory/$query"));
      // final response= await httpClient.get(Uri(path:'$_baseurl/searchCategory'));
      print(response.body);
      if(response.statusCode==200){
        // Map<String,dynamic> map= json.decode(response.body);
        // List<Category> data=map['result'];
        // print(data[1]);
        Iterable categories= jsonDecode(response.body);
        print(categories);
        List<Category> mappedCategory= List<Category>.from(categories
              .map((category) => Category.fromJson(category)))
              .toList();
        
        return mappedCategory;
      }else{
        throw Exception("Error");
      }
    } on SocketException catch (e) {
      throw e;
    } on HttpException catch (e) {
      throw e;
    }
    }
  
  }