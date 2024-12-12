import 'package:blood_donation/app/public/reset_password_screen/reset_password_screen.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/core/widget/global_sub_title_text_widget.dart';
import 'package:blood_donation/core/widget/global_title_text_widget.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:blood_donation/app/public/forgot_password/view_model/cubit/forgot_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pinput/pinput.dart';

import '../../../core/enum/request_state.dart';
import '../../../core/widget/global_snackbar.dart';
import 'enter_code_otp_fileds_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          forgotPasswortListener(state, context);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Password recovery".tr(context)),
            ),
            body: Form(
              key: context.read<ForgotPasswordCubit>().formKey,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalTitleTextWidget(
                            title: 'Forgot Password'.tr(context)),
                        SizedBox(
                          height: 15,
                        ),
                        GlobalSubTitleTextWidget(
                          subTitle:
                              'In our app, we take the security of your information seriously.'
                                  .tr(context),
                        ),
                        SizedBox(height: 30),
                        GlobalTextFormFiled(
                          textEditingController: context
                              .read<ForgotPasswordCubit>()
                              .emailController,
                          lableText: 'Email or Phone Number'.tr(context),
                          keyboardType: TextInputType.emailAddress,
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Please enter your email or phone number'
                                  .tr(context);
                            }
                            return null;
                          },
                        ),
                      ]),
                ),
              ),
            ),
            bottomNavigationBar: state.forgotPasswordState ==
                    RequestState.loading
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Loading...".tr(context))
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: GlobalButton(
                        text: 'Reset Password'.tr(context),
                        onTap: () {
                          final cubit = context.read<ForgotPasswordCubit>();
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.otpController.clear();
                            cubit.newPassowordController.clear();
                            cubit.confirmPasswordController.clear();
                            context.read<ForgotPasswordCubit>().resetPassword();
                          }
                        })),
          );
        },
      ),
    );
  }

  void forgotPasswortListener(ForgotPasswordState state, BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    if (state.forgotPasswordState == RequestState.error) {
      globalSnackbar(context, state.errorMessage, backgroundColor: Colors.red);
    }
    if (state.forgotPasswordState == RequestState.success) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => EnterCodeOtpFiledsWidget(cubit: cubit));
      globalSnackbar(context,
          "Activation code has been sent.. Check your email".tr(context),
          backgroundColor: Colors.green);
    }
  }
}
