import 'package:flutter/material.dart';

import 'user_hospital_action_button.dart';

class UserHospitalActionButtons extends StatelessWidget {
  const UserHospitalActionButtons({Key? key, required this.primaryColor})
      : super(key: key);

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          UserHospitalActionButton(
            icon: Icons.call,
            label: 'Call',
            primaryColor: primaryColor,
            onPressed: () {},
          ),
          UserHospitalActionButton(
            icon: Icons.bloodtype_outlined,
            label: 'تبرع الان',
            primaryColor: primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
