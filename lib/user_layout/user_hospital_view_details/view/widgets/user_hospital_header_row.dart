import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../../hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';

class UserHospitalHeaderRow extends StatelessWidget {
  const UserHospitalHeaderRow(
      {Key? key,
      required this.hospitalProfileModel,
      required this.primaryColor})
      : super(key: key);

  final HospitalProfileModel hospitalProfileModel;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(hospitalProfileModel.name!,
              style: const TextStyle(fontSize: 25)),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.email),
          label: Text('Email'.tr(context)),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Theme.of(context).colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
