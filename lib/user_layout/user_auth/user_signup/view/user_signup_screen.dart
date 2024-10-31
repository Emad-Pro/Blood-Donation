import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/location_service/widget/location_dailog.dart';
import 'package:blood_donation/core/widget/global_button.dart';

import 'package:blood_donation/user_layout/user_auth/user_signup/view_model/cubit/user_signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../../core/location_service/location_service.dart';
import 'widget/user_signup_name_email_phone_widgets.dart';
import 'widget/user_signup_title_subtile_widgets.dart';
import 'widget/user_signup_confirm_has_problem_widget.dart';
import 'widget/user_signup_last_date_blood_donation_widget.dart';
import 'widget/user_signup_password_location_widgets.dart';
import 'widget/user_signup_select_blood_widget.dart';
import 'widget/user_signup_select_gender_widget.dart';

class UserSignupScreen extends StatelessWidget {
  const UserSignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Signup',
        ),
      ),
      body: BlocProvider(
        create: (context) => UserSignupCubit(getIt<LocationService>()),
        child: BlocConsumer<UserSignupCubit, UserSignupState>(
          listener: (context, state) {
            if (state.permissionRequestState == RequestState.error) {
              showPermissionDialog(
                  context: context,
                  onPressed: () {
                    getIt<LocationService>().openAppSettings();
                    Navigator.of(context).pop();
                  });
            }
          },
          builder: (context, state) {
            final userSignUpCubit = context.read<UserSignupCubit>();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserSignupTitleSubtitleWidgets(),
                    UserSignupNameEmailPhoneWidgets(
                        userSignUpCubit: userSignUpCubit),
                    UserSignupPasswordLocationWidgets(
                        userSignUpCubit: userSignUpCubit),
                    UserSignupSelectGenderWidget(
                        userSignUpCubit: userSignUpCubit, state: state),
                    UserSignupSelectBloodWidget(
                        userSignUpCubit: userSignUpCubit, state: state),
                    UserSignupLastDateBloodDonationWidget(
                        userSignUpCubit: userSignUpCubit),
                    UserSignupConfirmhasProblemWidget(
                      userSignupCubit: userSignUpCubit,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlobalButton(text: "Sign Up".tr(context), onTap: () {}),
      ),
    );
  }
}
