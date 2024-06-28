import 'package:flutter/material.dart';
import 'package:testing/home_model.dart';

class MyHomePageVm extends ChangeNotifier {
  final HomeModel _calculatorModel = HomeModel();

  int get result => _calculatorModel.result;
  int get result2 => _calculatorModel.result2;
  String get hello => _calculatorModel.hello;

  void calculate() {
    _calculatorModel.calculate();
    notifyListeners();
  }
}
