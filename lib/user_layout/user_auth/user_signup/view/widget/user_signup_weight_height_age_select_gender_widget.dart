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
        GlobalTextFormFiled(
          keyboardType: TextInputType.number,
          readOnly: true,
          textEditingController: userSignUpCubit.ageController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Date of birth required'.tr(context);
            } else
              return null;
          },
          lableText: "Date of birth".tr(context),
          //  maxLength: 2,
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            ).then((value) {
              if (value != null) {
                userSignUpCubit.ageController.text =
                    "${value.year}-${value.month}-${value.day}";
              }
            });
          },
          iconButton: Icon(Icons.calendar_month),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: GlobalTextFormFiled(
                keyboardType: TextInputType.number,
                maxLength: 3,
                textEditingController: userSignUpCubit.weightController,
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
                textEditingController: userSignUpCubit.heightController,
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
