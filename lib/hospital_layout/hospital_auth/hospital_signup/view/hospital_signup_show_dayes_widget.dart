import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/cubit/hospital_signup_cubit.dart';

class HospitalSignupShowDayesWidget extends StatelessWidget {
  const HospitalSignupShowDayesWidget(
      {Key? key, required this.hospitalSignupCubit})
      : super(key: key);
  final HospitalSignupCubit hospitalSignupCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HospitalSignupCubit, HospitalSignupState>(
        bloc: hospitalSignupCubit,
        builder: (context, state) {
          return ListView(
            //  mainAxisSize: MainAxisSize.min,
            children: state.daysOfWeek.map((day) {
              return CheckboxListTile(
                title: Text(day.tr(context)),
                value: state.selectedDays.contains(day) ||
                    (day == 'Select all' && state.allSelected),
                onChanged: (_) => hospitalSignupCubit.toggleDay(day),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
