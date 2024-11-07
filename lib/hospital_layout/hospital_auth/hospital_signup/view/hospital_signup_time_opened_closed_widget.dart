import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../view_model/cubit/hospital_signup_cubit.dart';

class HospitalSignupTimeOpenedClosedWidgets extends StatelessWidget {
  const HospitalSignupTimeOpenedClosedWidgets({
    super.key,
    required this.hospitalSignupCubit,
  });
  final HospitalSignupCubit hospitalSignupCubit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        hospitalSignupCubit.selectOpeningTime(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            )),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            if (hospitalSignupCubit.state.openingTime != null)
              Text(hospitalSignupCubit.state.openingTime!.format(context)),
            Text(hospitalSignupCubit.state.openingTime == null
                ? "Work Hours".tr(context)
                : " - "),
            if (hospitalSignupCubit.state.closingTime != null)
              Text(hospitalSignupCubit.state.closingTime!.format(context)),
            Spacer(),
            Icon(Icons.timer_sharp),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
