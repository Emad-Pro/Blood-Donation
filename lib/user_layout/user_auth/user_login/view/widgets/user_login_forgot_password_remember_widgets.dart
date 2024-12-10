import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/public/forgot_password/user_forgot_password_screen.dart';
import '../../view_model/cubit/user_cubit.dart';

class UserLoginForgotPasswordRememberWidgets extends StatelessWidget {
  const UserLoginForgotPasswordRememberWidgets(
      {super.key, required this.state});
  final UserLoginState state;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).colorScheme.primary,
              value: state.userRememberMe,
              onChanged: (bool? value) {
                context.read<UserLoginCubit>().toggleRememberME();
              },
            ),
            Text(
              'Remember me'.tr(context),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen()));
          },
          child: Text('Forgot Password?'.tr(context)),
        ),
      ],
    );
  }
}
