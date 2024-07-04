import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:login/models/user.dart';

class LogInViewModel with ChangeNotifier {
  final AuthService _authService;
  UserModel? _loggedInUser;
  bool _passwordVisible = false;
  bool _showValidationMessage = false;
  bool _isLoading = false;
  String? _error;

  String? emailError;
  String? passwordError;
  String? allError;

  LogInViewModel({AuthService? authService})
      : _authService = authService ?? AuthService();

  UserModel? get loggedInUser => _loggedInUser;
  bool get passwordVisible => _passwordVisible;
  bool get showValidationMessage => _showValidationMessage;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    return (value == null || value.isEmpty)
        ? 'Email is required.'
        : (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value))
            ? 'Enter a valid email.'
            : null;
  }

  String? validatePassword(String? value) {
    return (value == null || value.isEmpty) ? 'Password is required.' : null;
  }

  Future<bool> validateAll(
      BuildContext context, String emailVal, String passwordVal) async {
    emailError = validateEmail(emailVal);
    passwordError = validatePassword(passwordVal);

    if (emailVal.isEmpty && passwordVal.isEmpty) {
      allError = 'Email and Password are required.';
    } else {
      allError = null;
    }

    _showValidationMessage =
        emailError != null || passwordError != null || allError != null;
    notifyListeners();

    return !_showValidationMessage;
  }

  Future<Map<String, String>> getValidatedValues(
      BuildContext context, String emailVal, String passwordVal) async {
    bool isValid = await validateAll(context, emailVal, passwordVal);

    if (!isValid) {
      throw Exception("Validation failed");
    }

    return {
      'email': base64Encode(utf8.encode(emailVal)),
      'password': base64Encode(utf8.encode(passwordVal)),
    };
  }

  Future<void> login(BuildContext context,String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final validatedValues = await getValidatedValues(context ,email, password);
      if (validatedValues.isNotEmpty) {
        final user = await _authService.login(
            validatedValues['email']!, validatedValues['password']!);
        if (user != null) {
          _loggedInUser = user;
        } else {
          _error = 'Login failed';
        }
      }
    } catch (e) {
      _error = 'An error occurred: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
