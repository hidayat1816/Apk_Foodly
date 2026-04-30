import 'package:flutter/material.dart';
import '../data/services/api_service.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool isLoading = false;
  String? error;

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await _api.login(email, password);

      if (token != null) {
        await _api.saveToken(token);
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        error = "Login gagal";
      }
    } catch (e) {
      error = "Terjadi error";
    }

    isLoading = false;
    notifyListeners();
    return false;
  }
}