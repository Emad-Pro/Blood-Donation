import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/hospital_edit_profile_cubit.dart';

class HospitalEditProfileEmailField extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfileEmailField({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalTextFormFiled(
      readOnly: true,
      lableText: "Email".tr(context),
      textEditingController: cubit.emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'please enter your email'.tr(context);
        } else {
          return null;
        }
      },
    );
  }
}
