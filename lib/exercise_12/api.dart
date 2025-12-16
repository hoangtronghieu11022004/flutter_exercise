import 'package:my_exercise/exercise_12/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductAPI {
  Future<List<Product>?> getAllProduct() async {
    var url = 'https://fakestoreapi.com/products';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    }
    return null;
  }
}