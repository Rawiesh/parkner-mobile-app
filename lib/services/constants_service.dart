import 'dart:convert';

import 'package:http/http.dart' as http;

class ConstantsService {
  String? apiUrl;

  Future<void> updateApiUrl() async {
    final response =
        await http.get(Uri.parse('https://parkner-urls.vercel.app/api/urls'));
    dynamic data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      apiUrl = data["urls"]["api"] + "/api";
      print("Api url: $apiUrl");
    }
  }
}
