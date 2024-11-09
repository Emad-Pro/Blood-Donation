import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_signup_cubit.dart';
import 'user_signup_picked_teaked_image.dart';

class UserSignupImageNameEmailWidgets extends StatelessWidget {
  const UserSignupImageNameEmailWidgets({
    super.key,
    required this.userSignUpCubit,
  });

  final UserSignupCubit userSignUpCubit;

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
                          userSignupPickedTakedImage(context, userSignUpCubit);
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
                          child: userSignUpCubit.state.selectedProfileImage !=
                                  null
                              ? Image.file(
                                  userSignUpCubit.state.selectedProfileImage!,
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
                lableText: "Full Name".tr(context),
                textEditingController: userSignUpCubit.fullNameController,
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
                lableText: "Email".tr(context),
                keyboardType: TextInputType.emailAddress,
                textEditingController: userSignUpCubit.emailController,
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
