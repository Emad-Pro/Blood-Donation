import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_signup_cubit.dart';

class UserSignupLastDateBloodDonationWidget extends StatelessWidget {
  const UserSignupLastDateBloodDonationWidget({
    super.key,
    required this.userSignUpCubit,
  });

  final UserSignupCubit userSignUpCubit;

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
          textEditingController:
              userSignUpCubit.dateLastBloodDonationController,
          readOnly: true,
          onTap: () async {
            DateTime currentDate = DateTime.now();
            DateTime threeMonthsAgo = DateTime(
                currentDate.year, currentDate.month - 3, currentDate.day);
            await showDatePicker(
                    context: context,
                    firstDate: DateTime(1970),
                    initialDate: threeMonthsAgo,
                    lastDate: DateTime.now())
                .then((onValue) {
              if (onValue != null) {
                userSignUpCubit.lastDonation = onValue;
                userSignUpCubit.dateLastBloodDonationController.text =
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
