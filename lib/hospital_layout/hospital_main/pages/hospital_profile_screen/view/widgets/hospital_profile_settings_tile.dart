// File for class HospitalProfileSettingsTile

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/settings_screen/view/settings_screen.dart';

class HospitalProfileSettingsTile extends StatelessWidget {
  const HospitalProfileSettingsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Text("Settings".tr(context)),
      leading: CircleAvatar(child: Icon(Icons.settings)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsScreen()));
      },
    );
  }
}
