import 'package:flutter/material.dart';

import 'user_hospital_action_buttons.dart';

import 'user_hospital_image_container.dart';

class UserHospitalHeaderSection extends StatelessWidget {
  const UserHospitalHeaderSection({Key? key, required this.primaryColor})
      : super(key: key);

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          UserHospitalImageContainer(primaryColor: primaryColor),
          UserHospitalActionButtons(primaryColor: primaryColor),
        ],
      ),
    );
  }
}
