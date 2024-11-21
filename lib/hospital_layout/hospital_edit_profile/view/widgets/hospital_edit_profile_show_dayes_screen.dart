// File for class HospitalEditProfileShowDayesScreen

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/hospital_edit_profile_cubit.dart';

class HospitalEditProfileShowDayesScreen extends StatelessWidget {
  const HospitalEditProfileShowDayesScreen(
      {Key? key, required this.hospitalEditProfileCubit})
      : super(key: key);
  final HospitalEditProfileCubit hospitalEditProfileCubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HospitalEditProfileCubit, HospitalEditProfileState>(
        bloc: hospitalEditProfileCubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Select Operating Days".tr(context)),
                Expanded(
                  child: ListView(
                    children: state.daysOfWeek.map((day) {
                      return CheckboxListTile(
                        title: Text(day.tr(context)),
                        value: state.days!.contains(day) ||
                            (day == 'Select all' && state.allSelected),
                        onChanged: (_) =>
                            hospitalEditProfileCubit.toggleDay(day),
                      );
                    }).toList(),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Done".tr(context)))
              ],
            ),
          );
        },
      ),
    );
  }
}
