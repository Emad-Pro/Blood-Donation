import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_signup_cubit.dart';

class UserSignupWeightHeightAgeAndSelectGenderWidget extends StatelessWidget {
  const UserSignupWeightHeightAgeAndSelectGenderWidget(
      {super.key, required this.userSignUpCubit, required this.state});

  final UserSignupCubit userSignUpCubit;
  final UserSignupState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        GlobalTextFormFiled(
          keyboardType: TextInputType.number,
          textEditingController: userSignUpCubit.ageController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your age'.tr(context);
            } else
              return null;
          },
          lableText: "Age".tr(context),
        ),
        SizedBox(
          height: 8,
        ),
        GlobalTextFormFiled(
          keyboardType: TextInputType.number,
          textEditingController: userSignUpCubit.weightController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your weight'.tr(context);
            } else
              return null;
          },
          lableText: "weight".tr(context),
        ),
        SizedBox(
          height: 8,
        ),
        GlobalTextFormFiled(
          keyboardType: TextInputType.number,
          textEditingController: userSignUpCubit.heightController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your height'.tr(context);
            } else
              return null;
          },
          lableText: "Height".tr(context),
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
            items: userSignUpCubit.genderTypes.map((String bloodType) {
              return DropdownMenuItem<String>(
                value: bloodType,
                child: Text(bloodType.tr(context)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              print(newValue);
              userSignUpCubit.toggleSelectedGender(newValue!);
            },
          ),
        ),
      ],
    );
  }
}
