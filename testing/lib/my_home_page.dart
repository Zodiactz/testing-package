import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/my_home_page_vm.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyHomePageVm>(builder: (context, vm, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                '2 + 1 = ${vm.result}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '2 + 2 = ${vm.result2}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                '${vm.hello}',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      );
    });
  }
}
