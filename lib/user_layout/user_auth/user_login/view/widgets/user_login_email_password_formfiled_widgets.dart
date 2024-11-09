import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widget/globla_textformfiled.dart';
import '../../view_model/cubit/user_cubit.dart';

class UserLoginEmailPasswordFormfiledWidgets extends StatelessWidget {
  const UserLoginEmailPasswordFormfiledWidgets(
      {super.key, required this.state});
  final UserLoginState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlobalTextFormFiled(
          lableText: "email".tr(context),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter Email';
            } else {
              return null;
            }
          },
          textEditingController: context.read<UserLoginCubit>().emailController,
        ),
        const SizedBox(height: 16),
        GlobalTextFormFiled(
            lableText: "password".tr(context),
            isSecure: state.userPasswordIsSecure,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Passwor';
              } else {
                return null;
              }
            },
            textEditingController:
                context.read<UserLoginCubit>().passwordController,
            iconButton: IconButton(
                onPressed: () {
                  context.read<UserLoginCubit>().toggleShowPassword();
                },
                icon: Icon(state.userPasswordIsSecure
                    ? Icons.visibility_off
                    : Icons.visibility)),
            keyboardType: TextInputType.visiblePassword),
        const SizedBox(height: 16),
      ],
    );
  }
}
