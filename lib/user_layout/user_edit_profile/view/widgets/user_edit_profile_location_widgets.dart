import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_edit_profile_cubit.dart';

class UserEditProfileLocationWidgets extends StatelessWidget {
  const UserEditProfileLocationWidgets({
    super.key,
    required this.userEditProfileCubit,
  });
  final UserEditProfileCubit userEditProfileCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalTextFormFiled(
          keyboardType: TextInputType.text,
          textEditingController: userEditProfileCubit.locationController,
          lableText: "Current Location".tr(context),
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your location'.tr(context);
            }
            return null;
          },
          iconButton: IconButton(
              onPressed: () {
                userEditProfileCubit.getLocation();
              },
              icon: Icon(Icons.location_on)),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
