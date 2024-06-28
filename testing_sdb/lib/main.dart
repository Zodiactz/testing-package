import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:login/view_models/locales.dart';
import 'package:provider/provider.dart';

import 'package:login/views/login_page.dart';
import 'package:login/view_models/login_view_model.dart';

import 'package:homepage/views/home_page.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LogInViewModel(),
          ),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoftDebut',
      theme: ThemeData(primarySwatch: Colors.blue),
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }

  void configureLocalization() {
    localization.init(mapLocales: LOCALES, initLanguageCode: "en");
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    setState(
      () {},
    );
  }
}
