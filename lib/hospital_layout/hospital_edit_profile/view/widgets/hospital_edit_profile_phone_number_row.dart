// File for class HospitalEditProfilePhoneNumberRow

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_edit_profile/view/widgets/hospital_edit_profile_service_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/hospital_edit_profile_cubit.dart';

class HospitalEditProfilePhoneNumberRow extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfilePhoneNumberRow({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HospitalEditProfileServiceDropdown(
          selectedService: cubit.state.selectedPhoneService,
          onServiceChanged: cubit.toggleServicePhone,
          serviceList: cubit.nameServicePhone,
        ),
        SizedBox(width: 8),
        Expanded(
          child: GlobalTextFormFiled(
            lableText: "Phone Number".tr(context),
            keyboardType: TextInputType.phone,
            maxLength: 7,
            textEditingController: cubit.phoneController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'please enter your phone number'.tr(context);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
