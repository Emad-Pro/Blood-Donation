// File for class HospitalEditProfileCurrentLocationField
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/hospital_edit_profile_cubit.dart';

class HospitalEditProfileCurrentLocationField extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfileCurrentLocationField({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalTextFormFiled(
      readOnly: true,
      onTap: () => cubit.getLocation(),
      iconButton: IconButton(
        onPressed: () => cubit.getLocation(),
        icon: Icon(Icons.location_on_outlined),
      ),
      lableText: "Current Location".tr(context),
      textEditingController: cubit.currentLocationController,
    );
  }
}
