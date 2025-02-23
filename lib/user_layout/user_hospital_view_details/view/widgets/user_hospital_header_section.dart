import 'package:flutter/material.dart';

import '../../../../hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'user_hospital_action_buttons.dart';

import 'user_hospital_image_container.dart';

class UserHospitalHeaderSection extends StatelessWidget {
  const UserHospitalHeaderSection({
    Key? key,
    required this.primaryColor,
    required this.hospitalProfileModel,
  }) : super(key: key);

  final Color primaryColor;
  final HospitalProfileModel hospitalProfileModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          UserHospitalImageContainer(primaryColor: primaryColor),
          UserHospitalActionButtons(
            primaryColor: primaryColor,
            hospitalProfileModel: hospitalProfileModel,
          ),
        ],
      ),
    );
  }
}
