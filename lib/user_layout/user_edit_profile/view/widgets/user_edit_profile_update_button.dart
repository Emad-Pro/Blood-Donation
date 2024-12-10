import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/enum/request_state.dart';
import '../../../../core/widget/global_button.dart';
import '../../view_model/cubit/user_edit_profile_cubit.dart';

class UserEditProfileUpdateButton extends StatelessWidget {
  const UserEditProfileUpdateButton(
      {super.key, required this.userEditProfileCubit, required this.state});

  final UserEditProfileCubit userEditProfileCubit;
  final UserEditProfileState state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (state.upoladImageState == RequestState.loading ||
              state.editProfileState == RequestState.loading)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 10,
                ),
                Text("Loading...".tr(context))
              ],
            )
          : GlobalButton(
              text: "Update".tr(context),
              onTap: () {
                if (userEditProfileCubit.formKey.currentState!.validate()) {
                  userEditProfileCubit.updateProfile();
                }
              }),
    );
  }
}
