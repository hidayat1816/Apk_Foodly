import 'package:flutter/material.dart';
import '../data/services/api_service.dart';

class OnboardingViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  String title = "Loading...";
  bool isLoading = true;

  Future<void> fetchTitle() async {
    try {
      isLoading = true;
      notifyListeners();

      title = await _apiService.getWelcomeText();
    } catch (e) {
      title = "Error load data";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}