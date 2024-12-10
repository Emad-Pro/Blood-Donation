import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_edit_profile_cubit.dart';

class UserEditProfileWeightHeightAgeAndSelectGenderWidget
    extends StatelessWidget {
  const UserEditProfileWeightHeightAgeAndSelectGenderWidget(
      {super.key, required this.userEditProfileCubit, required this.state});
  final UserEditProfileCubit userEditProfileCubit;
  final UserEditProfileState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GlobalTextFormFiled(
                keyboardType: TextInputType.number,
                textEditingController: userEditProfileCubit.ageController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Age required'.tr(context);
                  } else
                    return null;
                },
                lableText: "Age".tr(context),
                maxLength: 2,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: GlobalTextFormFiled(
                keyboardType: TextInputType.number,
                maxLength: 3,
                textEditingController: userEditProfileCubit.weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Weight required'.tr(context);
                  } else
                    return null;
                },
                lableText: "weight".tr(context),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: GlobalTextFormFiled(
                maxLength: 3,
                keyboardType: TextInputType.number,
                textEditingController: userEditProfileCubit.heightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Height required'.tr(context);
                  } else
                    return null;
                },
                lableText: "Height".tr(context),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            underline: SizedBox(),
            isExpanded: true,
            hint: Text('select gender'.tr(context)),
            value: state.selectedGender,
            items: userEditProfileCubit.genderTypes.map((String bloodType) {
              return DropdownMenuItem<String>(
                value: bloodType,
                child: Text(bloodType.tr(context)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              print(newValue);
              userEditProfileCubit.toggleGender(newValue!);
            },
          ),
        ),
      ],
    );
  }
}
