import 'package:blood_donation/app/public/forgot_password/view_model/cubit/forgot_password_cubit.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/enum/request_state.dart';
import '../../../../core/widget/global_snackbar.dart';

class EnterNewPsswordScreen extends StatelessWidget {
  const EnterNewPsswordScreen(
      {Key? key, required this.accessToken, required this.cubit})
      : super(key: key);
  final ForgotPasswordCubit cubit;
  final String accessToken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        bloc: cubit,
        listener: (context, state) {
          if (state.resetPasswordState == RequestState.error) {
            globalSnackbar(context, state.resetPasswordMessage,
                backgroundColor: Colors.red);
          } else if (state.resetPasswordState == RequestState.success) {
            Navigator.pop(context);
            Navigator.pop(context);
            globalSnackbar(
              context,
              "Password Changed Successfully".tr(context),
            );
            Supabase.instance.client.auth.signOut().then((onValue) {});
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        "Enter New Password".tr(context),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Column(
                          children: [
                            Text(
                              "Please Enter Your New Password".tr(context),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
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
                  child: Form(
                key: cubit.formKeyConfirmPassword,
                child: Column(
                  children: [
                    GlobalTextFormFiled(
                      isSecure: state.isSecure,
                      lableText: "Enter Password".tr(context),
                      textEditingController: cubit.newPassowordController,
                      validator: (value) {
                        if (value != cubit.confirmPasswordController.text) {
                          return "Password doesn't match".tr(context);
                        } else if (value!.isEmpty) {
                          return "Please Enter Password".tr(context);
                        }
                        return null;
                      },
                      iconButton: IconButton(
                          onPressed: () {
                            cubit.toggleIsSecure();
                          },
                          icon: state.isSecure
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GlobalTextFormFiled(
                      isSecure: state.isSecure,
                      lableText: "Re-Enter Password".tr(context),
                      textEditingController: cubit.confirmPasswordController,
                      validator: (value) {
                        if (value != cubit.newPassowordController.text) {
                          return "Password doesn't match".tr(context);
                        } else if (value!.isEmpty) {
                          return "Please Enter Password".tr(context);
                        }
                        return null;
                      },
                      iconButton: IconButton(
                          onPressed: () {
                            cubit.toggleIsSecure();
                          },
                          icon: state.isSecure
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                    ),
                  ],
                ),
              )),
              SliverPadding(
                sliver: SliverToBoxAdapter(
                  child: state.resetPasswordState == RequestState.loading
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [CircularProgressIndicator()],
                        )
                      : GlobalButton(
                          text: "Save Password".tr(context),
                          onTap: () {
                            if (cubit.formKeyConfirmPassword.currentState!
                                .validate()) {
                              print("sssssssssss");
                              cubit.updateUserPassword(accessToken);
                            }
                          }),
                ),
                padding: EdgeInsets.all(15),
              )
            ]),
          );
        },
      ),
    );
  }
}
