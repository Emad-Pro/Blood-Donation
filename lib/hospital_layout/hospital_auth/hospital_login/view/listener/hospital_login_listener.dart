import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_login/view_model/cubit/hospital_login_cubit.dart';
import 'package:blood_donation/hospital_layout/hospital_main/view/hospital_main_screen.dart';
import 'package:flutter/material.dart';

hospitalLoginListener(BuildContext context, HospitalLoginState state) {
  if (state.loginState == RequestState.loading) {
  } else if (state.loginState == RequestState.success) {
    globalSnackbar(
        context, "(Hospital Or Blood Center) Login Successfully".tr(context),
        backgroundColor: Colors.green);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HospitalMainScreen()),
        (Route<dynamic> route) => false);
  } else if (state.loginState == RequestState.error) {
    Navigator.pop(context);
    globalSnackbar(context, state.errorMessage!.tr(context),
        backgroundColor: Colors.red);
  }
}
