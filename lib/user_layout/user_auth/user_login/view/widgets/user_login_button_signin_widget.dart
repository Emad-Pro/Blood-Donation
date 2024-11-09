import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../../../core/widget/global_button.dart';
import '../../view_model/cubit/user_cubit.dart';

class UserLoginButtonSignInWidget extends StatelessWidget {
  const UserLoginButtonSignInWidget({
    super.key,
    required this.state,
  });
  final UserLoginState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        state.loginState == RequestState.loading
            ? Center(child: Center(child: CircularProgressIndicator()))
            : GlobalButton(
                text: "Login".tr(context),
                onTap: () {
                  if (context
                      .read<UserLoginCubit>()
                      .formKey
                      .currentState!
                      .validate()) {
                    context.read<UserLoginCubit>().signInWithEmailAndPassword();
                  }
                }),
        const SizedBox(height: 20),
      ],
    );
  }
}
