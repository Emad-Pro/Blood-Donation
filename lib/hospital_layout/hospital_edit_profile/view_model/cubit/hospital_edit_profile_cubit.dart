import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/enum/request_state.dart';
import '../../../hospital_auth/hospital_signup/model/hospital_signup_model.dart';

part 'hospital_edit_profile_state.dart';

class HospitalEditProfileCubit extends Cubit<HospitalEditProfileState> {
  HospitalEditProfileCubit(this.profile, this._locationService)
      : super(HospitalEditProfileState()) {
    initFailed();
  }
  final formKey = GlobalKey<FormState>();
  final LocationService _locationService;
  final List<String> nameServicePhone = ["Orange", "Zain", "Umniah"];
  final HospitalProfileModel profile;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();

  TextEditingController docsFileController = TextEditingController();
  TextEditingController primaryContactPersonController =
      TextEditingController();

  /// for Change Password

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final changePasswordKey = GlobalKey<FormState>();

  void initFailed() {
    _initializeTextFields();
    final selectedPhoneService = _getPhoneService(profile.phone!);
    final selectedPhoneServicePrimaryContactPerson =
        _getPhoneService(profile.primaryContactPerson!);
    final days = _parseDays(profile.dayes!);
    // إعداد أوقات العمل
    final openingTime = _parseTimeOfDay(profile.openingTime!);
    final closingTime = _parseTimeOfDay(profile.closingTime!);

    // تحديث الحالة
    emit(state.copyWith(
        selectedPhoneService: selectedPhoneService,
        selectedPhoneServicePrimaryContactPerson:
            selectedPhoneServicePrimaryContactPerson,
        days: days,
        openingTime: openingTime,
        closingTime: closingTime));
  }

  update() async {
    try {
      emit(state.copyWith(updateProfileState: RequestState.loading));
      final supabase = Supabase.instance.client;
      final map = _createHospitalSignupModel();
      if (profile.email != emailController.text) {
        print("email");
        await updateEmail();
      }
      await supabase
          .from("HospitalAuth")
          .update(map.toMap())
          .eq("uId", profile.uId!);

      emit(state.copyWith(updateProfileState: RequestState.success));
    } on SocketException catch (e) {
      emit(state.copyWith(
          updateProfileState: RequestState.error,
          updateProfileMessage: e.osError!.message));
    } catch (e) {
      emit(state.copyWith(
          updateProfileState: RequestState.error,
          updateProfileMessage: e.toString()));
    }
  }

  changePassword() {
    try {
      emit(state.copyWith(changePasswordState: RequestState.loading));
      final supabase = Supabase.instance.client;
      supabase.auth
          .updateUser(UserAttributes(password: passwordController.text));
      emit(state.copyWith(changePasswordState: RequestState.success));
    } on AuthException catch (e) {
      emit(state.copyWith(
          permissionRequestState: RequestState.error,
          permissionMessage: e.message));
    }
  }

  updateEmail() async {
    try {
      final supabase = Supabase.instance.client;
      print(emailController.text);
      await supabase.auth
          .updateUser(UserAttributes(email: emailController.text));
      //   supabase.auth.signOut();
    } on AuthException catch (e) {
      emit(state.copyWith(
          updateProfileState: RequestState.error,
          updateProfileMessage: e.message));
    } on SocketException catch (e) {
      emit(state.copyWith(
          updateProfileState: RequestState.error,
          updateProfileMessage: e.message));
    }
  }

  HospitalSignupModel _createHospitalSignupModel() {
    final phonePrimartCode = _getPhoneServiceWithName(
        state.selectedPhoneServicePrimaryContactPerson!);
    final phoneCode = _getPhoneServiceWithName(state.selectedPhoneService!);

    return HospitalSignupModel(
      email: emailController.text,
      name: nameController.text,
      phone: "${phoneCode}${phoneController.text}",
      latitude: double.tryParse(latitudeController.text),
      longitude: double.tryParse(longitudeController.text),
      primaryContactPerson:
          "${phonePrimartCode}${primaryContactPersonController.text}",
      currentLocation: currentLocationController.text,
      dayes: state.days,
      openingTime: '${state.openingTime!.hour}:${state.openingTime!.minute}',
      closingTime: '${state.closingTime!.hour}:${state.closingTime!.minute}',
      docsFile: profile.docsFile,
      uId: profile.uId.toString(),
    );
  }

  String _getPhoneServiceWithName(String serviceName) {
    return serviceName == 'Orange'
        ? '077'
        : serviceName == 'Zain'
            ? '079'
            : serviceName == 'Umniah'
                ? '078'
                : '077';
  }

  void _initializeTextFields() {
    nameController.text = profile.name!;
    emailController.text = profile.email!;
    phoneController.text = profile.phone!.replaceRange(0, 3, '');
    latitudeController.text = profile.latitude!.toString();
    longitudeController.text = profile.longitude!.toString();
    currentLocationController.text = profile.currentLocation!;

    docsFileController.text = profile.docsFile!;
    primaryContactPersonController.text =
        profile.primaryContactPerson!.replaceRange(0, 3, '');
  }

  String _getPhoneService(String phoneNumber) {
    final prefix = phoneNumber.substring(0, 3);
    switch (prefix) {
      case '077':
        return 'Orange';
      case '079':
        return 'Zain';
      case '078':
        return 'Umniah';
      default:
        return 'Unknown';
    }
  }

  List<String> _parseDays(String? days) {
    if (days == null || days.isEmpty) {
      return [];
    }
    try {
      return days
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map((e) => e.trim())
          .toList();
    } catch (e) {
      print('Error parsing days: $e');
      return [];
    }
  }

  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  void toggleDay(String day) {
    final updatedDays = List<String>.from(state.days!);
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
    emit(state.copyWith(days: updatedDays));
  }

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

  toggleServicePhone(String phoneService) {
    emit(state.copyWith(selectedPhoneService: phoneService));
  }

  toggleServicePhonePrimaryContactNumber(String phoneService) {
    emit(
        state.copyWith(selectedPhoneServicePrimaryContactPerson: phoneService));
  }

  selectClosingTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 23, minute: 0),
    );
    if (picked != null) emit(state.copyWith(closingTime: picked));
  }
}
