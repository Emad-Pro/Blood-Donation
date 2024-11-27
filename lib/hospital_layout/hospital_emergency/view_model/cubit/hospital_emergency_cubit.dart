import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'hospital_emergency_state.dart';

class HospitalEmergencyCubit extends Cubit<HospitalEmergencyState> {
  HospitalEmergencyCubit() : super(HospitalEmergencyState());
  TextEditingController bloodSelectedController = TextEditingController();
  toggleDiseaseSelection(String bloodType) {
    final updatedBloodTypes = Map<String, bool>.from(state.bloodSelected);
    updatedBloodTypes[bloodType] = !updatedBloodTypes[bloodType]!;
    emit(state.copyWith(bloodSelected: updatedBloodTypes));
    getSelectedDayes();
  }

  getSelectedDayes() {
    List<String> selectedDayes = state.bloodSelected.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    bloodSelectedController.text = selectedDayes.join(', ');
  }

  toggleTimeNeeded(String timeNeeded) {
    emit(state.copyWith(timeNeeded: timeNeeded));
  }

  toggleLocationDistance(int locationDistance) {
    emit(state.copyWith(locationDistance: locationDistance));
  }

  toggleUnitsRequired(int unitsRequired) {
    emit(state.copyWith(unitsRequired: unitsRequired));
  }
}
