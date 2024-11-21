// File for class HospitalEditProfilePWorkHoursSelector
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../view_model/cubit/hospital_edit_profile_cubit.dart';

class HospitalEditProfileWorkHoursSelector extends StatelessWidget {
  final HospitalEditProfileCubit cubit;

  const HospitalEditProfileWorkHoursSelector({Key? key, required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => cubit.selectOpeningTime(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            if (cubit.state.openingTime != null)
              Text(cubit.state.openingTime!.format(context)),
            Text(cubit.state.openingTime == null
                ? "Work Hours".tr(context)
                : " - "),
            if (cubit.state.closingTime != null)
              Text(cubit.state.closingTime!.format(context)),
            Spacer(),
            Icon(Icons.timer_sharp),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
