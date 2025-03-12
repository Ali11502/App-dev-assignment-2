import 'package:flutter/material.dart';

import '../model/rating.dart';
import '../service/rating_service.dart';


class RatingProvider extends ChangeNotifier {
  final _service = RatingService();
  bool isLoading = true;
  late Rating _rating;

  Rating get rating => _rating;

  Future<void> getRating(int productId) async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getRating(productId);
    _rating = response;
    isLoading = false;
    notifyListeners();
  }
}