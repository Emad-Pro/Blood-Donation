import 'package:blood_donation/user_layout/user_auth/user_signup/view_model/cubit/user_signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_lacator.dart';
import '../../../../core/location_service/location_service.dart';
import '../../../../core/widget/global_appbar.dart';
import 'listener/user_signup_listener.dart';
import 'widget/user_signup_button.dart';
import 'widget/user_signup_image_name_email_widgets.dart';
import 'widget/user_signup_password_confirm_password_widget.dart';
import 'widget/user_signup_title_subtile_widgets.dart';
import 'widget/user_signup_confirm_has_problem_widget.dart';
import 'widget/user_signup_last_date_blood_donation_widget.dart';
import 'widget/user_signup_phone_number_widgets.dart';
import 'widget/user_signup_select_blood_widget.dart';
import 'widget/user_signup_weight_height_age_select_gender_widget.dart';

class UserSignupScreen extends StatelessWidget {
  const UserSignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSignupCubit(getIt<LocationService>()),
      child: BlocConsumer<UserSignupCubit, UserSignupState>(
        listener: (context, state) => userSignupListener(context, state),
        builder: (context, state) {
          final userSignUpCubit = context.read<UserSignupCubit>();
          return Scaffold(
            appBar: globaleAppBar(context),
            body: SingleChildScrollView(
                child: Form(
                    key: userSignUpCubit.formKey,
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserSignupTitleSubtitleWidgets(),
                              UserSignupImageNameEmailWidgets(
                                  userSignUpCubit: userSignUpCubit),
                              UserSignupPasswordConfirmPasswordWidgets(
                                  userSignUpCubit: userSignUpCubit),
                              UserSignupPhoneNumberWidgets(
                                  userSignUpCubit: userSignUpCubit),
                              UserSignupWeightHeightAgeAndSelectGenderWidget(
                                  userSignUpCubit: userSignUpCubit,
                                  state: state),
                              UserSignupSelectBloodWidget(
                                  userSignUpCubit: userSignUpCubit,
                                  state: state),
                              UserSignupLastDateBloodDonationWidget(
                                  userSignUpCubit: userSignUpCubit),
                              UserSignupConfirmhasProblemWidget(
                                userSignupCubit: userSignUpCubit,
                              )
                            ])))),
            bottomNavigationBar: UserSignupButton(
                userSignUpCubit: userSignUpCubit, state: state),
          );
        },
      ),
    );
  }
}
