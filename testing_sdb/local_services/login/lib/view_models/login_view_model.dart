import 'package:flutter/material.dart';
import 'package:login/models/user.dart';
import '../services/auth_service.dart';
import 'dart:convert';

class LogInViewModel with ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        ? 'Email is required.' // TODO: This is a workaround to get the value from the locale data
        : (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value))
            ? 'Enter a valid email.' // TODO: This is a workaround to get the value from the locale data
            : null;
  }

  String? validatePassword(String? value) {
    return (value == null || value.isEmpty)
        ? 'Password is required.' // TODO: This is a workaround to get the value from the locale data
        : null;
  }

  Future<bool> validateAll(String emailVal, String passwordVal) async {
    emailError = validateEmail(emailVal);
    passwordError = validatePassword(passwordVal);

    if (emailVal.isEmpty && passwordVal.isEmpty) {
      allError =
          'Email and Password are required.'; // TODO: This is a workaround to get the value from the locale data
    } else {
      allError = null;
    }

    _showValidationMessage =
        emailError != null || passwordError != null || allError != null;
    notifyListeners();

    return !_showValidationMessage;
  }

  Future<Map<String, String>> getValidatedValues(
      String emailVal, String passwordVal) async {
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
}
