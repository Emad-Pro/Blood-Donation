import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'hospital_signup_state.dart';

class HospitalSignupCubit extends Cubit<HospitalSignupState> {
  HospitalSignupCubit()
      : super(
          HospitalSignupState(
            selectedDays: [],
            openingTime: TimeOfDay(hour: 8, minute: 0),
            closingTime: TimeOfDay(hour: 17, minute: 0),
          ),
        );

  void selectOpeningTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: state.openingTime,
    );
    if (picked != null) emit(state.copyWith(openingTime: picked));
  }

  void selectClosingTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: state.closingTime,
    );
    if (picked != null) emit(state.copyWith(closingTime: picked));
  }

  void toggleDay(String day) {
    final updatedDays = List<String>.from(state.selectedDays);
    if (day == 'Select all') {
      updatedDays
        ..clear()
        ..addAll(state.allSelected ? [] : state.daysOfWeek.sublist(0, 7));
    } else {
      if (updatedDays.contains(day)) {
        updatedDays.remove(day);
      } else {
        updatedDays.add(day);
      }
    }
    emit(state.copyWith(selectedDays: updatedDays));
  }
}
