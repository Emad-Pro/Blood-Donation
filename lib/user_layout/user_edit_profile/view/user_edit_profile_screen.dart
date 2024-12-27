import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/model/user_signup_model.dart';
import 'package:blood_donation/user_layout/user_edit_profile/view_model/cubit/user_edit_profile_cubit.dart';
import 'package:blood_donation/user_layout/user_profile/view_model/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/service_lacator.dart';
import '../../../core/enum/request_state.dart';
import '../../../core/widget/global_snackbar.dart';
import '../../user_edit_password/view/user_edit_password_screen.dart';
import 'widgets/user_edit_profile_diseases_button_widget.dart';
import 'widgets/user_edit_profile_image_name_email_widgets.dart';
import 'widgets/user_edit_profile_last_date_blood_donation_widget.dart';
import 'widgets/user_edit_profile_location_widgets.dart';
import 'widgets/user_edit_profile_phone_number_widgets.dart';
import 'widgets/user_edit_profile_selecet_blood_type.dart';
import 'widgets/user_edit_profile_update_button.dart';
import 'widgets/user_edit_profile_weight_height_age_and_select_gender_widget.dart';

class UserEditProfileScreen extends StatelessWidget {
  const UserEditProfileScreen({Key? key, required this.userSignupModel})
      : super(key: key);
  final UserSignupModel userSignupModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserEditProfileCubit(userSignupModel, getIt<LocationService>()),
      child: BlocConsumer<UserEditProfileCubit, UserEditProfileState>(
        listener: (context, state) {
          if (state.editProfileState == RequestState.success) {
            globalSnackbar(context, "Profile Updated Successfully".tr(context),
                backgroundColor: Colors.green);
            Navigator.pop(context);
            getIt<UserProfileCubit>().getUserProfile();
          } else if (state.editProfileState == RequestState.error) {
            globalSnackbar(context, state.errorMessage!,
                backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          final userEditProfileCubit = context.read<UserEditProfileCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Edit Profile".tr(context),
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserEditPasswordScreen(
                                    cubit: userEditProfileCubit,
                                  )));
                    },
                    child: Text("Change Password".tr(context)))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: userEditProfileCubit.formKey,
                  child: Column(
                    children: [
                      UserEditProfileImageNameEmailWidgets(
                          userEditProfileCubit: userEditProfileCubit),
                      UserEditProfileLocationWidgets(
                          userEditProfileCubit: userEditProfileCubit),
                      UserEditProfilePhoneNumberWidgets(
                          userEditProfileCubit: userEditProfileCubit,
                          state: state),
                      UserEditProfileWeightHeightAgeAndSelectGenderWidget(
                          state: state,
                          userEditProfileCubit: userEditProfileCubit),
                      UserEditProfileSelecetBloodType(
                          state: state,
                          userEditProfileCubit: userEditProfileCubit),
                      UserEditProfileLastDateBloodDonationWidget(
                          userEditProfileCubit: userEditProfileCubit),
                      UserEditProfileDiseasesButtonWidget(
                          userEditProfileCubit: userEditProfileCubit)
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: UserEditProfileUpdateButton(
                state: state, userEditProfileCubit: userEditProfileCubit),
          );
        },
      ),
    );
  }
}
