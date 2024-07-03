import 'dart:convert';
import 'package:authen_package/authen.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:login/constants/api_path.dart';
import 'package:provider/provider.dart';
import 'package:login/view_models/login_view_model.dart';
import 'package:login/view_models/locales.dart';
import 'package:login/utils/validation_message.dart';
import 'package:http/http.dart' as http;
import 'package:login/models/user.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //final tenancyController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //final tenancyFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  late FlutterLocalization _flutterLocalization;

  late String _currentLocale;
  final AuthService _authService = AuthService();
  UserModel? _loggedInUser;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
  }

  @override
  void dispose() {
    //tenancyController.dispose();
    emailController.dispose();
    passwordController.dispose();
    //tenancyFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context, LogInViewModel loginvm, String email, String password) async {
    
      _isLoading = true;
      _error = null;  // Clear previous error
    

    if (_formKey.currentState!.validate()) {
      bool isValid = await loginvm.validateAll(
        email,
        password,
      );

      if (isValid) {
        Map<String, String> encodedValues = await loginvm.getValidatedValues(
          email,
          password,
        );
        print('Email: $email');
        print('Password: $password');
        print('Email (encoded): ${encodedValues['email']}');
        print('Password (encoded): ${encodedValues['password']}');

        try {
          final user = await _authService.login(email, password);
          if (user != null) {
            _loggedInUser = user;
            print('Logged in as: ${_loggedInUser?.username}');

            Navigator.pushNamed(
              context,
              '/home',
              arguments: {
                'username': user.username,
                'email': email,
              },
            );
          } else {
            setState(() {
              _error = 'Login failed';
              print(_error);
            });
          }
        } catch (e) {
          setState(() {
            _error = 'An error occurred: $e';
            print(_error);
          });
        }
      }
    }

  
      _isLoading = false;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Consumer<LogInViewModel>(
        builder: (context, loginvm, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          // Background Field
                          IntrinsicHeight(
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      // Title
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LocaleData.title.getString(context),
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "AnyApprove",
                                            style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 28),

                                      // Login Validation Message
                                      if (loginvm.showValidationMessage)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .start, //don't change this
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 16.0,
                                              ),
                                              child: Container(
                                                child: Text(
                                                  LocaleData.accessError
                                                      .getString(context),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      SizedBox(height: 10),

                                      /* // Tenancy TextFormField
                                      MyTextFormField(
                                        controller: tenancyController,
                                        height: 52,
                                        hintText: LocaleData.tenancyCode
                                            .getString(context),
                                        obscureText: false,
                                        focusNode: tenancyFocusNode,
                                        prefixIcon: Icon(
                                          Icons.apartment,
                                          color: Colors.orangeAccent,
                                        ),
                                        errorMessage: loginvm.tenancyError,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(emailFocusNode);
                                        },
                                      ),

                                      SizedBox(height: 24),*/

                                      // Email TextFormField
                                      MyTextFormField(
                                        controller: emailController,
                                        height: 52,
                                        hintText:
                                            LocaleData.email.getString(context),
                                        obscureText: false,
                                        focusNode: emailFocusNode,
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.orangeAccent,
                                        ),
                                        errorMessage: loginvm.emailError,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(passwordFocusNode);
                                        },
                                      ),

                                      SizedBox(height: 24),

                                      // Password TextFormField
                                      MyTextFormField(
                                        controller: passwordController,
                                        height: 52,
                                        hintText: LocaleData.password
                                            .getString(context),
                                        obscureText: !loginvm.passwordVisible,
                                        focusNode: passwordFocusNode,
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.orangeAccent,
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(loginvm.passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          color: Colors.grey,
                                          onPressed: () {
                                            loginvm.togglePasswordVisibility();
                                          },
                                        ),
                                        errorMessage: loginvm.passwordError,
                                      ),

                                      SizedBox(height: 24),

                                      //showing validation message
                                      if (loginvm.showValidationMessage)
                                        ValidationMessageWidget(),

                                      SizedBox(height: 10),

                                      // Login Button
                                      ElevatedButton(
                                        onPressed: () {
                                          login(
                                            context,
                                            loginvm,
                                            emailController.text,
                                            passwordController.text,      
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orangeAccent,
                                          minimumSize:
                                              Size(double.infinity, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        child: Text(
                                          LocaleData.login.getString(context),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),

                                      SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Title Logo
                          Positioned(
                            top: -50,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(50),
                                      // Image Logo
                                      child: Image.asset(
                                        'assets/icon/cat.jfif',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),

                    // Language Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            _setLocale("en");
                          },
                          icon: CountryFlags.flag(
                            'GB',
                            width: 30,
                            height: 20,
                          ),
                          visualDensity: null,
                        ),
                        SizedBox(),
                        IconButton(
                          onPressed: () {
                            _setLocale("th");
                          },
                          icon: CountryFlags.flag(
                            'TH',
                            width: 30,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // SoftDebut Logo
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Image.asset(
              'assets/icon/softdebut.png',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
        ),
      ),
    );
  }

  void _setLocale(String locale) {
    _flutterLocalization.translate(locale);

    setState(
      () {
        _currentLocale = locale;
      },
    );
  }
}
