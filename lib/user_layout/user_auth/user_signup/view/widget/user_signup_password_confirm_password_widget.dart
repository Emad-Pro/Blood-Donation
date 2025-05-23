import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_signup_cubit.dart';

class UserSignupPasswordConfirmPasswordWidgets extends StatelessWidget {
  const UserSignupPasswordConfirmPasswordWidgets({
    super.key,
    required this.userSignUpCubit,
  });

  final UserSignupCubit userSignUpCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalTextFormFiled(
          keyboardType: TextInputType.visiblePassword,
          lableText: "Password".tr(context),
          isSecure: userSignUpCubit.state.isSecure,
          textEditingController: userSignUpCubit.passwordController,
          iconButton: IconButton(
              onPressed: () {
                userSignUpCubit.togglePasswordSecure();
              },
              icon: Icon(userSignUpCubit.state.isSecure
                  ? Icons.visibility_off
                  : Icons.visibility)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your password'.tr(context);
            } else if (userSignUpCubit.confirmPasswordController.text !=
                value) {
              return 'password not match'.tr(context);
            }
            return null;
          },
        ),
        SizedBox(
          height: 8,
        ),
        GlobalTextFormFiled(
          keyboardType: TextInputType.visiblePassword,
          isSecure: userSignUpCubit.state.isSecure,
          iconButton: IconButton(
              onPressed: () {
                userSignUpCubit.togglePasswordSecure();
              },
              icon: Icon(userSignUpCubit.state.isSecure
                  ? Icons.visibility_off
                  : Icons.visibility)),
          textEditingController: userSignUpCubit.confirmPasswordController,
          lableText: "Confirm Password".tr(context),
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your confirm password'.tr(context);
            } else if (userSignUpCubit.passwordController.text != value) {
              return 'password not match'.tr(context);
            }
            return null;
          },
        ),
        SizedBox(
          height: 8,
        ),
        GlobalTextFormFiled(
          keyboardType: TextInputType.text,
          textEditingController: userSignUpCubit.currentLocationController,
          lableText: "Current Location".tr(context),
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your location'.tr(context);
            }
            return null;
          },
          iconButton: IconButton(
              onPressed: () {
                userSignUpCubit.getLocation();
              },
              icon: Icon(Icons.location_on)),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
