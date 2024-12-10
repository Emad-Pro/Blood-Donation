import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../view_model/cubit/user_edit_profile_cubit.dart';

class UserEditProfileSelecetBloodType extends StatelessWidget {
  const UserEditProfileSelecetBloodType(
      {super.key, required this.userEditProfileCubit, required this.state});
  final UserEditProfileCubit userEditProfileCubit;
  final UserEditProfileState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            underline: Container(),
            focusColor: Theme.of(context).colorScheme.surface,
            iconDisabledColor: Theme.of(context).colorScheme.surface,
            isExpanded: true,
            hint: Text('Select Blood Type'.tr(context)),
            value: state.selectedBloodType,
            items: userEditProfileCubit.bloodTypes.map((String bloodType) {
              return DropdownMenuItem<String>(
                value: bloodType,
                child: Text(bloodType.tr(context)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              userEditProfileCubit.toggleBloodType(newValue!);
            },
          ),
        ),
      ],
    );
  }
}
