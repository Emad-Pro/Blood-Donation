import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/global_sub_title_text_widget.dart';
import '../../../../../core/widget/global_title_text_widget.dart';
import '../../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/hospital_signup_cubit.dart';

class HospitalSignupTitleSubtitleNameEmailWidgets extends StatelessWidget {
  const HospitalSignupTitleSubtitleNameEmailWidgets({
    super.key,
    required this.hospitalSignupCubit,
  });

  final HospitalSignupCubit hospitalSignupCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlobalTitleTextWidget(
          title: "Create Account For Hospital Or Blood Center".tr(context),
        ),
        SizedBox(height: 8),
        GlobalSubTitleTextWidget(
          subTitle:
              "Register now to join our network of trusted healthcare facilities. Manage donations, connect with donors, and play a vital role in saving lives!"
                  .tr(context),
        ),
        SizedBox(height: 8),
        GlobalTextFormFiled(
          textEditingController: hospitalSignupCubit.nameController,
          lableText: "Hospital Name Or Blood Center".tr(context),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Enter Hospital Name Or Blood Name".tr(context);
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: 8),
        GlobalTextFormFiled(
            lableText: "Email".tr(context),
            textEditingController: hospitalSignupCubit.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Email".tr(context);
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress),
        SizedBox(height: 8),
      ],
    );
  }
}
