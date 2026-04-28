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

  /// 🔥 TAMBAH KE CART
  void addToCart(Map<String, dynamic> item) {
    cartItems.add(item);
    notifyListeners();
  }

  /// 🔥 HAPUS ITEM
  void removeFromCart(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }

  /// 🔥 TOTAL HARGA
  int getTotal() {
    int total = 0;

    for (var item in cartItems) {
      total += item["price"] as int;
    }

    return total;
  }
}