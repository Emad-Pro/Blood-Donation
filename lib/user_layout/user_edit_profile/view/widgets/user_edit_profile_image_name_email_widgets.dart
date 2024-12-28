import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_edit_profile_cubit.dart';
import 'user_edit_profile_cubit.dart';

class UserEditProfileImageNameEmailWidgets extends StatelessWidget {
  const UserEditProfileImageNameEmailWidgets({
    super.key,
    required this.userEditProfileCubit,
  });

  final UserEditProfileCubit userEditProfileCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: InkWell(
                        onTap: () {
                          showSelecetImageDialog(context, userEditProfileCubit);
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.2)),
                          child: (userEditProfileCubit
                                      .state.selectedProfileImage !=
                                  null)
                              ? ClipRRect(
                                  child: Image.file(
                                    userEditProfileCubit
                                        .state.selectedProfileImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : userEditProfileCubit.state.imageProfile != null
                                  ? Image.network(
                                      userEditProfileCubit.state.imageProfile!,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 40,
                                    ),
                        )))),
            Text(
              "Photo Profile".tr(context),
              style: TextStyle(
                  fontSize: 12,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.5)),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
        Expanded(
          child: Column(
            children: [
              GlobalTextFormFiled(
                iconButton: Icon(Icons.person),
                lableText: "Full Name".tr(context),
                textEditingController: userEditProfileCubit.nameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your full name'.tr(context);
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              GlobalTextFormFiled(
                iconButton: Icon(Icons.email),
                lableText: "Email".tr(context),
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
                textEditingController: userEditProfileCubit.emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email'.tr(context);
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ],
    );
  }
}
