import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_main/view/user_main_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/global_snackbar.dart';

loginUserDonerSuccess(BuildContext context) {
  globalSnackbar(context, "User Login Successfully".tr(context),
      backgroundColor: Colors.green);
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => UserMainScreen()),
      (Route<dynamic> route) => false);
}

loginUserDonerError(BuildContext context, String? errorMessage) {
  globalSnackbar(context, errorMessage!.tr(context),
      backgroundColor: Colors.red);
}
