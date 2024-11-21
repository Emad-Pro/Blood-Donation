// File for class HospitalEditProfileOperatingDaysSelector
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../view_model/cubit/hospital_edit_profile_cubit.dart';
import 'hospital_edit_profile_show_dayes_screen.dart';

class HospitalEditProfileOperatingDaysSelector extends StatelessWidget {
  final HospitalEditProfileCubit cubit;
  final HospitalEditProfileState state;

  const HospitalEditProfileOperatingDaysSelector(
      {Key? key, required this.cubit, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => HospitalEditProfileShowDayesScreen(
          hospitalEditProfileCubit: cubit,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          state.days!.isEmpty
              ? "Select Operating Days".tr(context)
              : state.days!.length == 7
                  ? "All Days".tr(context)
                  : state.days!
                      .map((day) => day)
                      .join(', ')
                      .replaceAll("Sat", "Sat".tr(context))
                      .replaceAll("Fri", "Fri".tr(context))
                      .replaceAll("Sun", "Sun".tr(context))
                      .replaceAll("Mon", "Mon".tr(context))
                      .replaceAll("Tue", "Tue".tr(context))
                      .replaceAll("Wed", "Wed".tr(context))
                      .replaceAll("Thu", "Thu".tr(context)),
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
