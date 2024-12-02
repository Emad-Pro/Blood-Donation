import 'package:blood_donation/app/privacy_policy/view/privacy_policy.dart';
import 'package:blood_donation/app/terms_and_conditions/view/terms_and_conditions.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_login/view/listener/hospital_login_listener.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_login/view_model/cubit/hospital_login_cubit.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_signup/view/hospital_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/global_button.dart';
import '../../../../core/widget/global_sub_title_text_widget.dart';
import '../../../../core/widget/global_title_text_widget.dart';
import '../../../../core/widget/globla_textformfiled.dart';

class HospitalLoginScreen extends StatelessWidget {
  const HospitalLoginScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login".tr(context)),
      ),
      body: BlocProvider(
        create: (context) => HospitalLoginCubit(),
        child: SingleChildScrollView(
          child: BlocConsumer<HospitalLoginCubit, HospitalLoginState>(
            listener: hospitalLoginListener,
            builder: (context, state) {
              final hospitalLoginCuibt = context.read<HospitalLoginCubit>();

              return Form(
                key: hospitalLoginCuibt.formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GlobalTitleTextWidget(
                                title: 'Welcome Back'.tr(context)),
                            const SizedBox(height: 15),
                            GlobalSubTitleTextWidget(
                                subTitle:
                                    "We're excited to have you back! We can't wait to see the impact you've made since you last used the app."
                                        .tr(context)),
                            const SizedBox(height: 30),
                            GlobalTextFormFiled(
                              lableText: "email".tr(context),
                              textEditingController:
                                  hospitalLoginCuibt.emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your email'.tr(context);
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            GlobalTextFormFiled(
                                lableText: "password".tr(context),
                                isSecure: state.hospitalPasswordIsSecure,
                                iconButton: IconButton(
                                    onPressed: () {
                                      hospitalLoginCuibt.toggleShowPassword();
                                    },
                                    icon: Icon(state.hospitalPasswordIsSecure
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                keyboardType: TextInputType.visiblePassword,
                                textEditingController:
                                    hospitalLoginCuibt.passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your password'
                                        .tr(context);
                                  } else {
                                    return null;
                                  }
                                }),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor:
                                          Theme.of(context).colorScheme.primary,
                                      value: state.hospitalRememberMe,
                                      onChanged: (bool? value) {
                                        hospitalLoginCuibt.toggleRememberMe();
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
                            ),
                            const SizedBox(height: 20),
                            state.loginState == RequestState.loading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GlobalButton(
                                    text: "Login",
                                    onTap: () {
                                      if (hospitalLoginCuibt
                                          .formKey.currentState!
                                          .validate()) {
                                        hospitalLoginCuibt
                                            .hospitalSigninWithEmailAndPassword();
                                      }
                                    }),
                            const SizedBox(height: 20),
                            Center(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    "By logging, you agree to our".tr(context),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TermsAndConditionsScreen(),
                                            ));
                                      },
                                      child: Text(
                                        "Terms & Conditions".tr(context),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      )),
                                  Text(
                                    "and".tr(context),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PrivacyPolicyScreen(),
                                            ));
                                      },
                                      child: Text(
                                        "PrivacyPolicy.".tr(context),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                          ],
                        ),
                        Center(
                          child: Wrap(
                            children: [
                              Text(
                                "You don't have an account yet. Do you want to register an account?"
                                    .tr(context),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HospitalSignupScreen()));
                                  },
                                  child: Text(
                                    "Sign Up".tr(context),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
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
