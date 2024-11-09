import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../../../core/widget/global_snackbar.dart';
import '../../view_model/cubit/user_cubit.dart';

userLoginListener(BuildContext context, UserLoginState state) {
  if (state.loginState == RequestState.loading) {
  } else if (state.loginState == RequestState.success) {
    // Navigator.pop(context);
    globalSnackbar(context, "User Login Successfully".tr(context),
        backgroundColor: Colors.green);
  } else if (state.loginState == RequestState.error) {
    // Navigator.pop(context);
    globalSnackbar(context, state.errorMessage!.tr(context),
        backgroundColor: Colors.red);
  }
}
