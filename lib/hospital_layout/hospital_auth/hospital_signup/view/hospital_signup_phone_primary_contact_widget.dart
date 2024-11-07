import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../view_model/cubit/hospital_signup_cubit.dart';

class HospitalSignupPhonePrimaryContactWidgets extends StatelessWidget {
  const HospitalSignupPhonePrimaryContactWidgets({
    super.key,
    required this.hospitalSignupCubit,
  });

  final HospitalSignupCubit hospitalSignupCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalTextFormFiled(
            textEditingController: hospitalSignupCubit.phoneController,
            lableText: "Phone Number".tr(context),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Phone Number".tr(context);
              } else {
                return null;
              }
            }),
        SizedBox(height: 8),
        GlobalTextFormFiled(
          lableText: "Primary Contact Person".tr(context),
          keyboardType: TextInputType.name,
          textEditingController: hospitalSignupCubit.namePersonController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please Enter Primary Contact Person".tr(context);
            } else {
              return null;
            }
          },
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
