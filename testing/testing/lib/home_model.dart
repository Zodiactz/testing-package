import 'package:testing_package/testing_package.dart';

class HomeModel {
  final Calculator _calculator = Calculator();

  int result = 0;
  int result2 = 0;
  String hello = 'กล้วย';

  void calculate() {
    result = _calculator.addOne(2);
    result2 = _calculator.addTwo(2);
    hello = _calculator.getHello();
  }
}
