// File for class HospitalProfileLoading

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

class HospitalProfileLoading extends StatelessWidget {
  const HospitalProfileLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 15),
        Text(
          "Loading...".tr(context),
        )
      ],
    ));
  }
}
