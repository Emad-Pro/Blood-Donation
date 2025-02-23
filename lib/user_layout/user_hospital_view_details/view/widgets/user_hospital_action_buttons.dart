import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import '../../../user_send_appointment/view/blood_request_dialog.dart';
import 'user_hospital_action_button.dart';

class UserHospitalActionButtons extends StatelessWidget {
  const UserHospitalActionButtons({
    Key? key,
    required this.primaryColor,
    required this.hospitalProfileModel,
  }) : super(key: key);

  final Color primaryColor;
  final HospitalProfileModel hospitalProfileModel;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          UserHospitalActionButton(
            icon: Icons.call,
            label: 'Call'.tr(context),
            primaryColor: primaryColor,
            onPressed: () async {
              await EasyLauncher.call(number: hospitalProfileModel!.phone!);
            },
          ),
          UserHospitalActionButton(
            icon: Icons.bloodtype_outlined,
            label: 'blood now'.tr(context),
            primaryColor: primaryColor,
            onPressed: () {
              showScheduleDialog(
                hospitalProfileModel: hospitalProfileModel,
                context,
              );
            },
          ),
        ],
      ),
    );
  }
}
