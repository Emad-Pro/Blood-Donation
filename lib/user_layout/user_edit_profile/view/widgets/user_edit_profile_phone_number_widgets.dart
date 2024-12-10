import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_edit_profile_cubit.dart';

class UserEditProfilePhoneNumberWidgets extends StatelessWidget {
  const UserEditProfilePhoneNumberWidgets(
      {super.key, required this.userEditProfileCubit, required this.state});
  final UserEditProfileCubit userEditProfileCubit;
  final UserEditProfileState state;
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
                value: state.selectedPhoneService ??
                    userEditProfileCubit.nameServicePhone.first,
                items: userEditProfileCubit.nameServicePhone
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
                  userEditProfileCubit.togglePhoneService(newValue!);
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
                textEditingController: userEditProfileCubit.phoneController,
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
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
