import 'dart:convert';
import 'package:login/view_models/login_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:login/services/auth_service.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  LogInViewModel viewModel = LogInViewModel();
  MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    viewModel = LogInViewModel();
  });

  group('LogInViewModel', () {
    test('Initial values are correct', () {
      expect(viewModel.loggedInUser, isNull);
      expect(viewModel.passwordVisible, isFalse);
      expect(viewModel.showValidationMessage, isFalse);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);
    });

    test('Toggles password visibility', () {
      viewModel.togglePasswordVisibility();
      expect(viewModel.passwordVisible, isTrue);
      viewModel.togglePasswordVisibility();
      expect(viewModel.passwordVisible, isFalse);
    });

    test('Validates email correctly', () {
      expect(viewModel.validateEmail(''), 'Email is required.');
      expect(viewModel.validateEmail('meow'), 'Enter a valid email.');
      expect(viewModel.validateEmail('test@example.com'), isNull);
    });

    test('Validates password correctly', () {
      expect(viewModel.validatePassword(''), 'Password is required.');
      expect(viewModel.validatePassword('password'), isNull);
    });

    /*test('Validates all fields correctly', () async {
      expect(await viewModel.validateAll( ,'test@example.com', 'password'), isTrue);
      expect(viewModel.showValidationMessage, isFalse);
      expect(await viewModel.validateAll('', ''), isFalse);
      expect(viewModel.showValidationMessage, isTrue);
      expect(viewModel.allError, 'Email and Password are required.');
    });

    test('Returns validated values as base64 encoded', () async {
      final values = await viewModel.getValidatedValues('test@example.com', 'password');
      expect(values['email'], base64Encode(utf8.encode('test@example.com')));
      expect(values['password'], base64Encode(utf8.encode('password')));
    });*/
  });
}
