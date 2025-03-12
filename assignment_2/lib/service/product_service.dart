import 'package:dio/dio.dart';

import '../model/product.dart';
import '../model/rating.dart';

class ProductService {
  final dio = Dio();

  Future<List<Product>> getAllProducts() async {
    Response response;
    response = await dio.get("https://fakestoreapi.com/products");

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      List<Product> products = data.map((e) {
        Rating rating = Rating.fromJson(e['rating']);

        return Product(
          id: e['id'],
          title: e['title'],
          price: (e['price'] as num).toDouble(),
          description: e['description'],
          category: e['category'],
          image: e['image'],
          rating: rating,
        );
      }).toList();
      return products;
    } else {
      throw Exception("Failed to get data");
    }
  }
}