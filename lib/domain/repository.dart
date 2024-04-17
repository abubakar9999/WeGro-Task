import 'package:flutter/material.dart';
import 'package:wegrow_task_flutter/models/product_model.dart';
import 'package:http/http.dart' as http;

class Repository{
    Future<List<ProductModel>> getProduct() async {
    List<ProductModel> products = [];
    try {
      
      final http.Response response = await http.get(
        Uri.parse("https://fakestoreapi.com/products"),
      );

      if (response.statusCode == 200) {
        products = productModelFromJson(response.body);

        return products;
      }
    } catch (e) {
      debugPrint('${e.toString()} in https://fakestoreapi.com/products');
      throw Exception(e);
    }
    return products;
  }
}