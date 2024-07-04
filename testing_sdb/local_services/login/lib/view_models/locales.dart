import 'package:flutter_localization/flutter_localization.dart';

const List<MapLocale> LOCALES = [ //ลองเปลี่ยนไปใช้ของflutterเลยดู
    MapLocale("en", LocaleData.EN),
    MapLocale("th", LocaleData.TH),
  ];

mixin LocaleData {

  static const String title = 'title';
  static const String accessError = 'accessError';
  static const String tenancyCode = 'tenancyCode';
  static const String tenancyCodeRequired = 'tenancyCodeRequired';
  static const String email = 'email';
  static const String emailRequired = 'emailRequired';
  static const String emailInvalid = 'emailInvalid';
  static const String password = 'password';
  static const String passwordRequired = 'passwordRequired';
  static const String passwordInvalid = 'passwordInvalid';
  static const String allRequired = 'allRequired';
  static const String login = 'login';

  static const Map<String, dynamic> EN = {
    title: 'Log in to ',
    accessError: 'Please enter your account to access',
    tenancyCode: 'Tenancy Code',
    tenancyCodeRequired: 'Tenancy Code is required.',
    email: 'Email',
    emailRequired: 'Email is required.',
    emailInvalid: 'Enter a valid email.',
    password: 'Password',
    passwordRequired: 'Password is required.',
    passwordInvalid: 'Password must be at least 8 characters long and contain at least 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character.',
    allRequired: 'Tenancy Code, Email and Password are required.',
    login: 'Login',
  };
  static const Map<String, dynamic> TH = {
    title: 'เข้าสู่ระบบ ',
    accessError: 'กรุณากรอกข้อมูลเพื่อเข้าถึงระบบ',
    tenancyCode: 'รหัสบริษัท',
    tenancyCodeRequired: 'กรุณาระบุรหัสบริษัท',
    email: 'อีเมล',
    emailRequired: 'กรุณาระบุอีเมล',
    emailInvalid: 'รูปแบบอีเมลไม่ถูกต้อง',
    password: 'รหัสผ่าน',
    passwordRequired: 'กรุณาระบุรหัสผ่าน',
    passwordInvalid: 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร ประกอบด้วย 1 ตัวอักษรตัวใหญ่, 1 ตัวอักษรตัวเล็ก, 1 ตัวเลข และ 1 ตัวอักษรพิเศษ',
    allRequired: 'กรุณาระบุรหัสบริษัท อีเมล และรหัสผ่าน',
    login: 'เข้าสู่ระบบ',
  };
}