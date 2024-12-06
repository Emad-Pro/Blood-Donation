import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../../../app/settings_screen/view/settings_screen.dart';
import 'user_profile_logout_show_dialog.dart';
import 'user_profile_option_tile.dart';

class UserProfileOptionsWidgets extends StatelessWidget {
  const UserProfileOptionsWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserProfileOptionTile(
          icon: Icons.edit,
          title: "Edit Profile".tr(context),
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
          icon: Icons.card_giftcard,
          title: "Rewards".tr(context),
        ),
        UserProfileOptionTile(
            icon: Icons.logout,
            title: "Logout".tr(context),
            onTap: () {
              userProfileLogoutShowDialog(context);
            }),
      ],
    );
  }
}
