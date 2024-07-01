import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  Map? user;

  Future<String?> loginUser({
    required String username,
    required String password,
  }) async {
    user?.clear();

    final response = await http.post(
      Uri.parse('https://parkner.vercel.app/api/users/login'),
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
    user?.clear();

    final response = await http.post(
      Uri.parse('https://parkner.vercel.app/api/users/sign-up'),
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
}
