import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_edit_profile/view_model/cubit/user_edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_preferences/cache_helper.dart';
import '../../../core/widget/globla_textformfiled.dart';

class UserEditPasswordScreen extends StatelessWidget {
  const UserEditPasswordScreen({Key? key, required this.cubit})
      : super(key: key);
  final UserEditProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password".tr(context)),
      ),
      body: BlocBuilder<UserEditProfileCubit, UserEditProfileState>(
        bloc: cubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: cubit.changePasswordKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    GlobalTextFormFiled(
                        isSecure: state.oldPasswordIsSecure,
                        iconButton: IconButton(
                            onPressed: () {
                              cubit.toggleShowOldPassowrd();
                            },
                            icon: state.oldPasswordIsSecure == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        lableText: "Old Password".tr(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Old Password".tr(context);
                          } else if (CacheHelper.getSaveData(key: "password") !=
                              value) {
                            return "Old Password Not Match".tr(context);
                          } else
                            return null;
                        }),
                    SizedBox(
                      height: 12,
                    ),
                    GlobalTextFormFiled(
                        isSecure: state.newPsswordIsSecure,
                        iconButton: IconButton(
                            onPressed: () {
                              cubit.toggleShowNewPassowrd();
                            },
                            icon: state.newPsswordIsSecure == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        textEditingController: cubit.passwordController,
                        lableText: "New Password".tr(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter new password".tr(context);
                          } else if (value !=
                              cubit.confirmPasswordController.text) {
                            return "Password Not Match".tr(context);
                          } else
                            return null;
                        }),
                    SizedBox(
                      height: 12,
                    ),
                    GlobalTextFormFiled(
                        isSecure: state.newPsswordIsSecure,
                        iconButton: IconButton(
                            onPressed: () {
                              cubit.toggleShowNewPassowrd();
                            },
                            icon: state.newPsswordIsSecure == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        textEditingController: cubit.confirmPasswordController,
                        lableText: "Confirm new Password".tr(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Password".tr(context);
                          } else if (value !=
                              cubit.confirmPasswordController.text) {
                            return "Password Not Match".tr(context);
                          } else
                            return null;
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (cubit.changePasswordKey.currentState!
                              .validate()) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        title:
                                            Text("Change Password".tr(context)),
                                        content: Text(
                                            "Are you sure to change password"
                                                .tr(context)),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child:
                                                  Text("Cancel".tr(context))),
                                          TextButton(
                                              onPressed: () =>
                                                  cubit.changePassword(),
                                              child:
                                                  Text("Confirm".tr(context)))
                                        ]));
                          }
                        },
                        child: Text("Change Password".tr(context))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
