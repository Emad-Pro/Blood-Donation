// File for class HospitalEditProfileScreen
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../../core/enum/request_state.dart';
import '../../../../core/widget/global_snackbar.dart';
import '../../../hospital_main/pages/hospital_profile_screen/view_model/cubit/hospital_profile_cubit.dart';
import '../../view_model/cubit/hospital_edit_profile_cubit.dart';

/// Listens to the state changes of the hospital edit profile process and
/// provides feedback to the user. If the profile is updated successfully,
/// a success snackbar is shown, the current screen is closed, and the
/// hospital profile information is refreshed. If there's an error, an
/// error snackbar is displayed with the error message.
void hospitalEditProfileListener(
    HospitalEditProfileState state, BuildContext context) {
  if (state.updateProfileState == RequestState.success) {
    globalSnackbar(context, "Profile Updated Successfully".tr(context),
        backgroundColor: Colors.green);
    Navigator.pop(context);
    getIt<HospitalProfileCubit>().getInfo();
  } else if (state.updateProfileState == RequestState.error) {
    globalSnackbar(context, state.updateProfileMessage!,
        backgroundColor: Colors.red);
  }
}
