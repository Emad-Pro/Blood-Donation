import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/global_button.dart';
import '../../../../../core/widget/global_snackbar.dart';
import '../../view_model/cubit/user_signup_cubit.dart';

class UserSignupButton extends StatelessWidget {
  const UserSignupButton(
      {super.key, required this.userSignUpCubit, required this.state});

  final UserSignupCubit userSignUpCubit;
  final UserSignupState state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlobalButton(
          text: "Sign Up".tr(context),
          onTap: () {
            if (userSignUpCubit.formKey.currentState!.validate()) {
              if (state.selectedBloodType == null ||
                  state.selectedGender == null) {
                globalSnackbar(
                    context,
                    (state.selectedBloodType == null
                        ? "Please Select Blood Type".tr(context)
                        : "Please Select Gender".tr(context)));
              } else {
                userSignUpCubit.signupUserWithEmailAndPassword();
              }
            }
          }),
    );
  }
}
