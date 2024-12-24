import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_profile/view_model/user_profile_cubit.dart';
import 'package:flutter/material.dart';

import 'user_profile_stat_card.dart';

class UserProfilePersonInfoCardWidgets extends StatelessWidget {
  const UserProfilePersonInfoCardWidgets({super.key, required this.state});
  final UserProfileState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UserProfileStatCard(
                  label: "Age".tr(context),
                  value: state.userSignupModel!.age.toString(),
                  icon: Icons.calendar_today,
                ),
                UserProfileStatCard(
                  label: "weight".tr(context),
                  value: "${state.userSignupModel!.weight} ${"kg".tr(context)}",
                  icon: Icons.line_weight_rounded,
                ),
                UserProfileStatCard(
                  label: "Height".tr(context),
                  value: "${state.userSignupModel!.height} ${"cm".tr(context)}",
                  icon: Icons.accessibility_new,
                ),
                UserProfileStatCard(
                  label: "Blood type".tr(context),
                  value: state.userSignupModel!.selectedBloodType!,
                  icon: Icons.bloodtype_rounded,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
