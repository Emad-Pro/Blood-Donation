import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_signup_cubit.dart';

class UserSignupNameEmailPhoneWidgets extends StatelessWidget {
  const UserSignupNameEmailPhoneWidgets({
    super.key,
    required this.userSignUpCubit,
  });

  final UserSignupCubit userSignUpCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalTextFormFiled(
          lableText: "Full Name".tr(context),
          textEditingController: userSignUpCubit.fullNameController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your full name'.tr(context);
            }

            return null;
          },
        ),
        SizedBox(
          height: 8,
        ),
        GlobalTextFormFiled(
          lableText: "Email".tr(context),
          keyboardType: TextInputType.emailAddress,
          textEditingController: userSignUpCubit.emailController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your email'.tr(context);
            }

            return null;
          },
        ),
        SizedBox(
          height: 8,
        ),
        GlobalTextFormFiled(
          lableText: "Phone Number".tr(context),
          keyboardType: TextInputType.phone,
          textEditingController: userSignUpCubit.phoneController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your phone number'.tr(context);
            }
            return null;
          },
        ),
      ],
    );
  }
}
