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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 90,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButton<String>(
                underline: SizedBox(),
                isExpanded: true,
                value: hospitalSignupCubit.state.selectedPhoneService ??
                    hospitalSignupCubit.nameServicePhone.first,
                items: hospitalSignupCubit.nameServicePhone
                    .map((String sericePhone) {
                  return DropdownMenuItem<String>(
                    value: sericePhone,
                    child: Text(
                      sericePhone.tr(context),
                      style: TextStyle(fontSize: 12),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue == 'Orange') {
                    print("077");
                  } else if (newValue == 'Omniah') {
                    print("078");
                  } else if (newValue == 'Zain') {
                    print("079");
                  }

                  hospitalSignupCubit.toggleServicePhone(newValue!);
                },
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: GlobalTextFormFiled(
                lableText: "Phone Number".tr(context),
                keyboardType: TextInputType.phone,
                maxLength: 7,
                textEditingController: hospitalSignupCubit.phoneCodeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your phone number'.tr(context);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
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
