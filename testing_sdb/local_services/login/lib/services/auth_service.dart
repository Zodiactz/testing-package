import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/models/user.dart';

class AuthService {
  final String baseUrl = "https://dummyjson.com/users"; // Endpoint to fetch users

  Future<UserModel?> login(String email, String password) async {
    final url = Uri.parse(baseUrl);
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['users'];
      for (var userJson in json) {
        if (userJson['email'] == email && userJson['password'] == password) {
          return UserModel.fromJson(userJson);
        }
      }
      print('Invalid credentials');
      return null;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }
}
