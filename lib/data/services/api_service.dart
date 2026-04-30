import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class ApiService {
  final String baseUrl =
      "https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok4";

  /// 🔹 API CHECK
  Future<String> getWelcomeText() async {
    final response = await http.get(Uri.parse("$baseUrl/check"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to load data");
    }
  }

  /// 🔐 LOGIN (AMBIL TOKEN)
  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["token"];
    } else {
      return null;
    }
  }

  /// 💾 SIMPAN TOKEN
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  /// 🔑 AMBIL TOKEN
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  /// 🛒 GET CART (SUDAH AMAN)
  Future<List<dynamic>> getCart() async {
    final token = await getToken();

    /// 🔥 HANDLE TOKEN NULL
    if (token == null) {
      throw Exception("Token tidak ditemukan, silakan login ulang");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/cart"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result["data"];
    } else {
      throw Exception("Failed to load cart");
    }
  }

  /// 🍔 GET PRODUCTS (SUDAH AMAN)
  Future<List<ProductModel>> getProducts() async {
    final token = await getToken();

    /// 🔥 HANDLE TOKEN NULL
    if (token == null) {
      throw Exception("Token tidak ditemukan, silakan login ulang");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/products"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    /// 🔥 DEBUG (boleh hapus nanti)
    print("STATUS API PRODUCT: ${response.statusCode}");
    print("BODY API PRODUCT: ${response.body}");

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      List data = result["data"];

      return data.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}