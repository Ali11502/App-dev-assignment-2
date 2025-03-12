import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/rating.dart';


class RatingService {
  final dio = Dio();
  Future<Rating> getRating(int productId) async {
    Response response;
    response =
    await dio.get("https://fakestoreapi.com/products/$productId");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;
      final Map<String, dynamic> ratingData = data['rating'];
      Rating rating = Rating(
        rate: ratingData['rate'],
        count: ratingData['count'],
      );
      return rating;
    } else {
      throw Exception("Failed to get geo data");
    }
  }
}