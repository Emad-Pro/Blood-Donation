import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/view_model/cubit/user_signup_cubit.dart';
import 'package:flutter/material.dart';

import 'user_signup_disease_selection.dart';

class UserSignupConfirmhasProblemWidget extends StatelessWidget {
  const UserSignupConfirmhasProblemWidget(
      {super.key, required this.userSignupCubit});
  final UserSignupCubit userSignupCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: userSignupCubit.state.isDisease,
              onChanged: (value) {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => UserSignupDiseaseSelection(
                        userSignupCubit: userSignupCubit)).then((onValue) {
                  userSignupCubit.toggleIsDisease();
                });
              },
            ),
            Expanded(
              child: Text(
                  "Are there any chronic diseases or contraindications to donation (prohibited diseases can be clarified, such as infectious or chronic diseases that prevent donation)"
                      .tr(context)),
            )
          ],
        ),
      ],
    );
  }
}
