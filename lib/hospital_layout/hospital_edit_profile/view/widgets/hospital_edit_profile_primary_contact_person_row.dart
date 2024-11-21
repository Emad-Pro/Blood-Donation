// File for class HospitalEditProfilePrimaryContactPersonRow
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/hospital_edit_profile_cubit.dart';

import 'hospital_edit_profile_service_dropdown.dart';

class HospitalEditProfilePrimaryContactPersonRow extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfilePrimaryContactPersonRow(
      {Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HospitalEditProfileServiceDropdown(
          selectedService: cubit.state.selectedPhoneServicePrimaryContactPerson,
          onServiceChanged: cubit.toggleServicePhonePrimaryContactNumber,
          serviceList: cubit.nameServicePhone,
        ),
        SizedBox(width: 8),
        Expanded(
          child: GlobalTextFormFiled(
            lableText: "Primary Contact Person".tr(context),
            keyboardType: TextInputType.phone,
            maxLength: 7,
            textEditingController: cubit.primaryContactPersonController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Primary Contact Person'.tr(context);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
