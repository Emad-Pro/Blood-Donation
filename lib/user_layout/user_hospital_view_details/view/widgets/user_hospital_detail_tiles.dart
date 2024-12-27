import 'package:flutter/material.dart';

import '../../../../core/methods/parse_days.dart';
import '../../../../hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'user_hospital_detail_tile.dart';

class UserHospitalDetailTiles extends StatelessWidget {
  const UserHospitalDetailTiles(
      {Key? key,
      required this.hospitalProfileModel,
      required this.primaryColor})
      : super(key: key);

  final HospitalProfileModel hospitalProfileModel;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      UserHospitalDetailTile(
          icon: Icons.email,
          text: hospitalProfileModel.email!,
          primaryColor: primaryColor),
      UserHospitalDetailTile(
          icon: Icons.phone,
          text: hospitalProfileModel.phone!,
          primaryColor: primaryColor),
      UserHospitalDetailTile(
        icon: Icons.timer_outlined,
        text:
            "${formatTime(hospitalProfileModel.openingTime!, context)} - ${formatTime(hospitalProfileModel.closingTime!, context)}",
        primaryColor: primaryColor,
      ),
      UserHospitalDetailTile(
        icon: Icons.date_range,
        text: parseDays(hospitalProfileModel.dayes!, context).join(", "),
        primaryColor: primaryColor,
      ),
      UserHospitalDetailTile(
          icon: Icons.location_on,
          text: hospitalProfileModel.currentLocation!,
          primaryColor: primaryColor),
    ]);
  }

  String formatTime(String time, BuildContext context) {
    final parts = time.split(":");
    return TimeOfDay(
            hour: int.parse(parts.first), minute: int.parse(parts.last))
        .format(context);
  }
}
