import 'package:blood_donation/app/public/forgot_password/enter_new_pssword_screen/enter_new_pssword_screen.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../core/widget/global_snackbar.dart';
import 'view_model/cubit/forgot_password_cubit.dart';

class EnterCodeOtpFiledsWidget extends StatelessWidget {
  const EnterCodeOtpFiledsWidget({super.key, required this.cubit});
  final ForgotPasswordCubit cubit;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: Colors.red),
      ),
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            bloc: cubit,
            listener: (context, state) {
              if (state.otpState == RequestState.error) {
                globalSnackbar(context, state.otpMessage,
                    backgroundColor: Colors.red);
              }
              if (state.otpState == RequestState.success) {
                globalSnackbar(context, state.otpMessage,
                    backgroundColor: Colors.green);
                Navigator.pop(context);
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return EnterNewPsswordScreen(
                          accessToken: state.authResponse!.session!.accessToken,
                          cubit: cubit);
                    });
              }
            },
            builder: (context, state) {
              return CustomScrollView(slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "Enter Verification Code".tr(context),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Column(
                            children: [
                              Text(
                                "We have sent the verification code to"
                                    .tr(context),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7)),
                              ),
                              Text(
                                cubit.emailController.text,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Pinput(
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    controller: cubit.otpController,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    length: 6,
                    onCompleted: (pin) {},
                    onChanged: (value) {},
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                        ),
                      ],
                    ),
                    defaultPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.2)),
                      ),
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface),
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.primary),
                        )),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: state.otpState == RequestState.loading
                      ? Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              cubit.resetPasswordWithOtp();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          "Confirm".tr(context),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.2),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                )
              ]);
            }),
      ),
    );
  }
}
