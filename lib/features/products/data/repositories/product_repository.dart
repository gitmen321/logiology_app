import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> fetchProducts({int skip = 0, int limit = 10}) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['products'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    }
    throw Exception('Failed to load products');
  }
}