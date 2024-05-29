import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/product_entity.dart';

class Network {
  Future<List<ProductEntity>> fetchProducts() async {
    try {
      String url = 'https://fakestoreapi.com/products';

      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);

        // convert json to list of product entity
        List<ProductEntity> products = (decodedData as List<dynamic>)
            .map<ProductEntity>((json) => ProductEntity.fromJson(json))
            .toList();

        return products;
      }
      return [];

      // throw Exception('Failed to load product data');
    } catch (err) {
      log('Error: $err');
      return [];
    }
  }

  
}
