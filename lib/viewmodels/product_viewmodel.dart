import 'package:flutter/material.dart';
import '../data/services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  List products = [];
  bool isLoading = true;

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      products = await _api.getProducts();
    } catch (e) {
      products = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}