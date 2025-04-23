import 'package:http/http.dart' as http;
import 'package:logiology_app/core/constants/app_constants.dart';
import 'dart:convert';
import '../models/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> fetchProducts({int skip = 0, int limit = 30}) async {
    final response = await http.get(
      Uri.parse(AppConstants.apiUrl(limit: limit, skip: skip)),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['products'] as List)
          .map((json) {
            // Mock tags based on product attributes
            final List<String> mockTags = [];
            final price = (json['price'] as num).toDouble();
            final rating = (json['rating'] as num).toDouble();
            if (price < 100) mockTags.add('sale');
            if (rating > 4.5) mockTags.add('popular');
            if (json['stock'] > 50) mockTags.add('new'); // Example condition
            return ProductModel.fromJson({
              ...json,
              'tags': mockTags, // Add mock tags to JSON
            });
          })
          .toList();
    }
    throw Exception('Failed to load products');
  }
}