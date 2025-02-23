import 'dart:convert';

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';

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
          onPressed: () async {
            await EasyLauncher.sms(number: hospitalProfileModel.phone!);
          },
          icon: const Icon(Icons.email),
          label: Text('Send Message'.tr(context)),
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
