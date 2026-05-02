import 'package:flutter/material.dart';
import '../data/services/api_service.dart';

/// 🔥 GLOBAL INSTANCE (BIAR 1 DATA DI SEMUA HALAMAN)
final CartViewModel cartVM = CartViewModel();

class CartViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  /// 🔥 TYPE AMAN
  List<Map<String, dynamic>> cartItems = [];

  bool isLoading = true;
  bool _loaded = false;

  /// ================= FETCH API (OPSIONAL)
  Future<void> fetchCart() async {
    try {
      if (_loaded) return;

      isLoading = true;
      notifyListeners();

      final apiData = await _api.getCart();

      /// 🔥 PAKSA FORMAT AMAN
      cartItems.addAll(
        List<Map<String, dynamic>>.from(apiData),
      );

      _loaded = true;
    } catch (e) {
      debugPrint("ERROR FETCH CART: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ================= ADD TO CART
  void addToCart(Map<String, dynamic> item) {
    final index =
        cartItems.indexWhere((e) => e['name'] == item['name']);

    if (index != -1) {
      cartItems[index]['qty'] =
          (cartItems[index]['qty'] ?? 1) + 1;
    } else {
      item['qty'] = 1;
      cartItems.add(item);
    }

    notifyListeners();

    /// 🔥 DEBUG
    print("CART SEKARANG: $cartItems");
  }

  /// ================= HAPUS ITEM
  void removeFromCart(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }

  /// ================= TOTAL (BERSIH TANPA WARNING)
  int getTotal() {
    int total = 0;

    for (var item in cartItems) {
      final price = int.tryParse(item["price"].toString()) ?? 0;
      final qty = int.tryParse(item["qty"].toString()) ?? 1;

      total += price * qty;
    }

    return total;
  }
}