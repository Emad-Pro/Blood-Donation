import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';

import 'package:blood_donation/hospital_layout/hospital_main/view/hospital_main_screen.dart';
import 'package:flutter/material.dart';

hospitalLoginSuccess(BuildContext context) {
  globalSnackbar(
      context, "(Hospital Or Blood Center) Login Successfully".tr(context),
      backgroundColor: Colors.green);
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HospitalMainScreen()),
      (Route<dynamic> route) => false);
}

hospitalLoginErorr(BuildContext context, String? errorMessage) {
  Navigator.pop(context);
  globalSnackbar(context, errorMessage!.tr(context),
      backgroundColor: Colors.red);
}
