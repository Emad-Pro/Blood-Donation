import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_edit_profile/view/user_edit_profile_screen.dart';
import 'package:blood_donation/user_layout/user_profile/view_model/user_profile_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../app/settings_screen/view/settings_screen.dart';
import '../../../hospital_faqs/view/hospital_faqs_screen.dart';
import '../../../my_appointment/view/my_appointment_screen.dart';
import '../../../user_payments/view/user_pyments_screen.dart';
import 'user_profile_logout_show_dialog.dart';
import 'user_profile_option_tile.dart';

class UserProfileOptionsWidgets extends StatelessWidget {
  const UserProfileOptionsWidgets({
    super.key,
    required this.state,
  });
  final UserProfileState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserProfileOptionTile(
          icon: Icons.edit,
          title: "Edit Profile".tr(context),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserEditProfileScreen(
                        userSignupModel: state.userSignupModel!,
                      )),
            );
          },
        ),
        UserProfileOptionTile(
          icon: Icons.settings,
          title: 'Settings'.tr(context),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsScreen()));
          },
        ),
        UserProfileOptionTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserPymentsScreen()),
            );
          },
          icon: Icons.card_travel,
          title: "My Payments".tr(context),
        ),
        UserProfileOptionTile(
          icon: Icons.question_answer,
          title: "FAQs".tr(context),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HospitalFaqsScreen()));
          },
        ),
        UserProfileOptionTile(
          icon: Icons.bloodtype_outlined,
          title: "My donations".tr(context),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAppointmentScreen()));
          },
        ),
        UserProfileOptionTile(
            icon: Icons.logout,
            title: "Logout".tr(context),
            onTap: () {
              userProfileLogoutShowDialog(context, state.userSignupModel!.uId!);
            }),
      ],
    );
  }
}
