import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../data/services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = []; // 🔥 TAMBAHAN
  bool isLoading = true;

  Future<void> fetchProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      products = await _api.getProducts();

      // 🔥 default: tampilkan semua data
      filteredProducts = products;

    } catch (e) {
      products = [];
      filteredProducts = [];
      debugPrint("Error Product: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // 🔍 🔥 FUNCTION SEARCH (INI YANG PENTING)
  void searchProduct(String query) {
    if (query.isEmpty) {
      filteredProducts = products;
    } else {
      filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }
}