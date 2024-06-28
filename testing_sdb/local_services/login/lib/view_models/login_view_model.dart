import 'dart:convert';

import 'package:flutter/cupertino.dart';
//import 'package:flutter_localization/flutter_localization.dart';
import 'package:login/view_models/locales.dart';

class LogInViewModel with ChangeNotifier {
  bool _passwordVisible = false;
  bool _showValidationMessage = false;
  String? tenancyError;
  String? emailError;
  String? passwordError;
  String? allError;

  static const String tenancyCodeRequired = LocaleData.tenancyCodeRequired;

  bool get passwordVisible => _passwordVisible;
  bool get showValidationMessage => _showValidationMessage;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  String? validateTenancy(String? value) {

    return (value == null || value.isEmpty)
        ? tenancyCodeRequired // TODO: This is a workaround to get the value from the locale data
        : null;
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
        : (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                .hasMatch(value))
            ? 'Password must be at least 8 characters long and contain at least 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character.' // TODO: This is a workaround to get the value from the locale data
            : null;
  }

  Future<bool> validateAll(
      String tenancyVal, String emailVal, String passwordVal) async {
    tenancyError = validateTenancy(tenancyVal);
    emailError = validateEmail(emailVal);
    passwordError = validatePassword(passwordVal);

    if (tenancyVal.isEmpty && emailVal.isEmpty && passwordVal.isEmpty) {
      allError =
          'Tenancy Code, Email and Password are required.'; // TODO: This is a workaround to get the value from the locale data
    } else {
      allError = null;
    }

    _showValidationMessage = tenancyError != null ||
        emailError != null ||
        passwordError != null ||
        allError != null;

    notifyListeners();

    return !_showValidationMessage;
  }

  Future<Map<String, String>> getValidatedValues(
      String tenancyVal, String emailVal, String passwordVal) async {
    bool isValid = await validateAll(tenancyVal, emailVal, passwordVal);
    if (!isValid) {
      throw Exception("Validation failed");
    }

    return {
      'tenancy': base64Encode(utf8.encode(tenancyVal)),
      'email': base64Encode(utf8.encode(emailVal)),
      'password': base64Encode(utf8.encode(passwordVal)),
    };
  }
}
