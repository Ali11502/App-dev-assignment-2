import 'package:flutter/material.dart';
import '../model/product.dart';
import '../service/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final _service = ProductService();
  bool isLoading = true;
  List<Product> _products = [];
  List<Product> get products => _products;

  Future<void> getAllProducts() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAllProducts();
    _products = response;
    isLoading = false;
    notifyListeners();
  }
}