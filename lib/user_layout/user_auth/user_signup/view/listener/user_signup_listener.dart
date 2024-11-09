import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../../../core/widget/global_snackbar.dart';

userSignupListener(context, state) {
  if (state.loginState == RequestState.loading) {
    showDialog(
        context: context,
        builder: (context) => Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: double.infinity,
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text("Please Wait ...".tr(context),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 24)),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  } else if (state.loginState == RequestState.success) {
    Navigator.pop(context);
    globalSnackbar(context, "User Created Successfully".tr(context),
        backgroundColor: Colors.green);
    Navigator.pop(context);
  } else if (state.loginState == RequestState.error) {
    Navigator.pop(context);
    globalSnackbar(context, state.errorMessage.toString().tr(context),
        backgroundColor: Colors.red);
  }
}
