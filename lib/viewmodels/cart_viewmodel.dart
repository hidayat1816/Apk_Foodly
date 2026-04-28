import 'package:flutter/material.dart';
import '../data/services/api_service.dart';

class CartViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  List cartItems = [];
  bool isLoading = true;

  Future<void> fetchCart() async {
    try {
      isLoading = true;
      notifyListeners();

      cartItems = await _api.getCart();
    } catch (e) {
      cartItems = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}