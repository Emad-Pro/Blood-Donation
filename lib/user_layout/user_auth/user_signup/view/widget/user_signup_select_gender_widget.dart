import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../view_model/cubit/user_signup_cubit.dart';

class UserSignupSelectGenderWidget extends StatelessWidget {
  const UserSignupSelectGenderWidget(
      {super.key, required this.userSignUpCubit, required this.state});

  final UserSignupCubit userSignUpCubit;
  final UserSignupState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        underline: Container(),
        focusColor: Theme.of(context).colorScheme.surface,
        iconDisabledColor: Theme.of(context).colorScheme.surface,
        isExpanded: true,
        hint: Text('select gender'.tr(context)),
        value: state.selectedGender ?? userSignUpCubit.genderTypes[0],
        items: userSignUpCubit.genderTypes.map((String bloodType) {
          return DropdownMenuItem<String>(
            value: bloodType,
            child: Text(bloodType.tr(context)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          userSignUpCubit.toggleSelectedGender(newValue!);
        },
      ),
    );
  }
}
