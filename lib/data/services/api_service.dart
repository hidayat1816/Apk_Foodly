// ignore: unused_import
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok4";

  Future<String> getWelcomeText() async {
    final response = await http.get(Uri.parse("$baseUrl/check"));

    if (response.statusCode == 200) {
      return response.body; // hasil: "UTS Kelas B - Kelompok 4"
    } else {
      throw Exception("Failed to load data");
    }
  }
}
