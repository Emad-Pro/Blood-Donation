import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

part 'hospital_signup_state.dart';

class HospitalSignupCubit extends Cubit<HospitalSignupState> {
  HospitalSignupCubit(this._locationService) : super(HospitalSignupState());

  final LocationService _locationService;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController namePersonController = TextEditingController();

  selectOpeningTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 8, minute: 0),
    );
    print(picked);
    if (picked != null) {
      emit(state.copyWith(openingTime: picked));
      selectClosingTime(context);
    }
    ;
  }

  toggleIsSecure() {
    emit(state.copyWith(isObSecure: !state.isObSecure));
  }

  selectClosingTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 23, minute: 0),
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

  Future<void> pickMultipleFiles() async {
    List<File> files = state.selectedDocsFiles;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpeg', 'jpg', 'png'],
    );

    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();

      emit(state.copyWith(selectedDocsFiles: files));
    } else {
      print("لم يتم اختيار أي ملفات.");
    }
  }

  deletePickFile() {
    emit(state.copyWith(selectedDocsFiles: []));
  }

  // Locations Services
  Future<void> getLocation() async {
    try {
      Position? position = await _locationService.getCurrentLocation();

      if (position == null) {
        emit(state.copyWith(
            permissionRequestState: RequestState.error,
            permissionMessage: "Acces Denied"));
        return;
      }
      latitudeController.text = position.latitude.toString();
      longitudeController.text = position.longitude.toString();

      print('خط العرض: ${position.latitude}, خط الطول: ${position.longitude}');

      String locationAddress =
          await _locationService.getAddressFromCoordinates(position);

      currentLocationController.text = locationAddress;
      emit(state.copyWith(permissionRequestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(
          permissionRequestState: RequestState.error,
          permissionMessage: "Filed to get location"));
    }
  }
}
