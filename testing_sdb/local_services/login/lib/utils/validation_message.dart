import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login/view_models/login_view_model.dart';

class ValidationMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LogInViewModel>(builder: (context, loginvm, child) {
      return loginvm.showValidationMessage
          ? Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(
                    color: Color.fromRGBO(238, 236, 236, 1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red[800],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: (loginvm.allError != null)
                          ? Text(
                              '${loginvm.allError}'.trim(),
                              style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 14,
                              ),
                            )
                          : Text(
                              //'${loginvm.tenancyError ?? ''} ${loginvm.emailError ?? ''} ${loginvm.passwordError ?? ''}'
                              ' ${loginvm.emailError ?? ''} ${loginvm.passwordError ?? ''}'
                                  .trim(),
                              style: TextStyle(
                                color: Colors.red[800],
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            )
          : SizedBox();
    });
  }
}
