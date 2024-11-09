import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          onPressed: () {},
          child: Text('Forgot Password?'.tr(context)),
        ),
      ],
    );
  }
}
