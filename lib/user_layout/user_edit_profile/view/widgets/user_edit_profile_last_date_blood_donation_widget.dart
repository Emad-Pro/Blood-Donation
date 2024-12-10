import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_edit_profile_cubit.dart';

class UserEditProfileLastDateBloodDonationWidget extends StatelessWidget {
  const UserEditProfileLastDateBloodDonationWidget({
    super.key,
    required this.userEditProfileCubit,
  });
  final UserEditProfileCubit userEditProfileCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        GlobalTextFormFiled(
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.isEmpty) {
              return 'please enter your date of last blood donation'
                  .tr(context);
            }
            return null;
          },
          lableText: "Date of last blood donation".tr(context),
          textEditingController: userEditProfileCubit.lastDonationController,
          readOnly: true,
          onTap: () async {
            DateTime currentDate = DateTime.now();
            DateTime threeMonthsAgo = DateTime(
                currentDate.year, currentDate.month - 3, currentDate.day);
            await showDatePicker(
                    context: context,
                    firstDate: threeMonthsAgo,
                    initialDate: threeMonthsAgo,
                    lastDate: DateTime.now())
                .then((onValue) {
              if (onValue != null) {
                //    userSignUpCubit.lastDonation = onValue;
                userEditProfileCubit.lastDonationController.text =
                    '${onValue.day}/${onValue.month}/${onValue.year}';
              }
            });
          },
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
