// File for class HospitalHomeResentText

import 'package:blood_donation/app/public/choose_screen/view/choose_screen.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

class HospitalHomeResentText extends StatelessWidget {
  const HospitalHomeResentText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10.0, bottom: 10, left: 10, right: 10),
        child: Text(
          "Recent Donations".tr(context),
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
