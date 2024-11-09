import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_auth/user_login/view_model/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'listner/user_login_listener.dart';
import 'widgets/user_login_button_signin_widget.dart';
import 'widgets/user_login_dont_hove_account_widgets.dart';
import 'widgets/user_login_email_password_formfiled_widgets.dart';
import 'widgets/user_login_forgot_password_remember_widgets.dart';
import 'widgets/user_login_privacy_policy_text_button_widgets.dart';
import 'widgets/user_login_title_subtitle_widgets.dart';

class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login".tr(context))),
      body: BlocProvider(
        create: (context) => UserLoginCubit(),
        child: SingleChildScrollView(
          child: BlocConsumer<UserLoginCubit, UserLoginState>(
            listener: userLoginListener,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: context.read<UserLoginCubit>().formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserLoginTitleSubtitleWidgets(),
                      UserLoginEmailPasswordFormfiledWidgets(state: state),
                      UserLoginForgotPasswordRememberWidgets(state: state),
                      UserLoginButtonSignInWidget(state: state),
                      UserLoginPrivacyPolicyTextButtonWidgets(),
                      UserLoginDontHaveAccountWidgets(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
