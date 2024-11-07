import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../view_model/cubit/hospital_signup_cubit.dart';

class HospitalSignupPasswordWidgets extends StatelessWidget {
  const HospitalSignupPasswordWidgets({
    super.key,
    required this.hospitalSignupCubit,
  });

  final HospitalSignupCubit hospitalSignupCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalTextFormFiled(
          lableText: "Password".tr(context),
          keyboardType: TextInputType.visiblePassword,
          textEditingController: hospitalSignupCubit.passwordController,
          isSecure: hospitalSignupCubit.state.isObSecure,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter Password".tr(context);
            } else if (value !=
                hospitalSignupCubit.confirmPasswordController.text) {
              return "Password Not Match".tr(context);
            } else
              return null;
          },
          iconButton: IconButton(
              onPressed: () {
                hospitalSignupCubit.toggleIsSecure();
              },
              icon: Icon(hospitalSignupCubit.state.isObSecure
                  ? Icons.visibility
                  : Icons.visibility_off)),
        ),
        SizedBox(height: 8),
        GlobalTextFormFiled(
          lableText: "Confirm Password".tr(context),
          keyboardType: TextInputType.visiblePassword,
          isSecure: hospitalSignupCubit.state.isObSecure,
          textEditingController: hospitalSignupCubit.confirmPasswordController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please Enter Confirm Password".tr(context);
            } else if (value != hospitalSignupCubit.passwordController.text) {
              return "Password Not Match".tr(context);
            } else
              return null;
          },
          iconButton: IconButton(
              onPressed: () {
                hospitalSignupCubit.toggleIsSecure();
              },
              icon: Icon(hospitalSignupCubit.state.isObSecure
                  ? Icons.visibility
                  : Icons.visibility_off)),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
