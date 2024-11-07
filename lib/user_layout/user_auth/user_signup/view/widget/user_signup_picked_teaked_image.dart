import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/view_model/cubit/user_signup_cubit.dart';
import 'package:flutter/material.dart';

Future<dynamic> userSignupPickedTakedImage(
    BuildContext context, UserSignupCubit userSignUpCubit) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  trailing: Icon(Icons.camera),
                  title: Text("Take Photo".tr(context)),
                  onTap: () async {
                    await userSignUpCubit.takeImage();
                  },
                ),
                ListTile(
                  trailing: Icon(Icons.image),
                  title: Text("Pick Image".tr(context)),
                  onTap: () async {
                    await userSignUpCubit.pickImage();
                  },
                )
              ],
            ),
          ));
}
