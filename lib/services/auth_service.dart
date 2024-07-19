import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parkner_mobile_app/app/app.locator.dart';
import 'package:parkner_mobile_app/services/constants_service.dart';

class AuthService {
  final _constantsService = locator<ConstantsService>();
  Map? user;

  Future<String?> loginUser({
    required String username,
    required String password,
  }) async {
    clearUser();

    final response = await http.post(
      Uri.parse('${_constantsService.apiUrl}/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    final data = jsonDecode(response.body);

    if (data?.containsKey("username")) {
      user = data;
    }

    if (data?.containsKey("message")) {
      return data["message"];
    }

    return null;
  }

  Future<String?> signUpUser({
    required String username,
    required String email,
    required String password,
  }) async {
    clearUser();

    final response = await http.post(
      Uri.parse('${_constantsService.apiUrl}/users/sign-up'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (data?.containsKey("message")) {
      return data["message"];
    }

    return null;
  }

  void clearUser() {
    user = null;
  }
}
