import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/constants/api_path.dart';
import 'package:login/models/user.dart';

class AuthService {
  Future<UserModel?> login(String encodedEmail, String encodedPassword) async {
    final url = Uri.parse(ApiUrl.baseUrl);
    final headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(url, headers: headers);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['users'];
      final email = utf8.decode(base64Decode(encodedEmail));
      final password = utf8.decode(base64Decode(encodedPassword));

      for (var userJson in json) {
        if (userJson['email'] == email && userJson['password'] == password) {
          print('User found with email: $email');
          print("email encodeed = "+encodedEmail);
          print("epassword encodeed = "+encodedPassword);
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
