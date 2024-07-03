import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:login/models/user.dart';

class LogInViewModel with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _loggedInUser;
  bool _passwordVisible = false;
  bool _showValidationMessage = false;
  bool _isLoading = false;
  String? _error;

  String? emailError;
  String? passwordError;
  String? allError;

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
        : (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
            ? 'Enter a valid email.'
            : null;
  }

  String? validatePassword(String? value) {
    return (value == null || value.isEmpty)
        ? 'Password is required.'
        : null;
  }

  Future<bool> validateAll(String emailVal, String passwordVal) async {
    emailError = validateEmail(emailVal);
    passwordError = validatePassword(passwordVal);

    if (emailVal.isEmpty && passwordVal.isEmpty) {
      allError = 'Email and Password are required.';
    } else {
      allError = null;
    }

    _showValidationMessage = emailError != null || passwordError != null || allError != null;
    notifyListeners();

    return !_showValidationMessage;
  }

  Future<Map<String, String>> getValidatedValues(String emailVal, String passwordVal) async {
    bool isValid = await validateAll(emailVal, passwordVal);

    if (!isValid) {
      throw Exception("Validation failed");
    }

    if (isValid) {
      return {
        'email': base64Encode(utf8.encode(emailVal)),
        'password': base64Encode(utf8.encode(passwordVal)),
      };
    } else {
      _showValidationMessage = true;
      notifyListeners();
      return {};
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    if (await validateAll(email, password)) {
      try {
        final user = await _authService.login(email, password);
        if (user != null) {
          _loggedInUser = user;
        } else {
          _error = 'Login failed';
        }
      } catch (e) {
        _error = 'An error occurred: $e';
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
