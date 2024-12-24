import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_signup/model/hospital_signup_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/shared_preferences/cache_helper.dart';

part 'hospital_signup_state.dart';

class HospitalSignupCubit extends Cubit<HospitalSignupState> {
  HospitalSignupCubit(this._locationService) : super(HospitalSignupState());
  final List<String> nameServicePhone = ["Orange", "Zain", "Umniah"];
  final LocationService _locationService;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneCodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController primaryContactPersonController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  signupHospitalWithEmailAndPassword() async {
    emit(state.copyWith(signUpHospitalState: RequestState.loading));
    try {
      await addHospitalToDatabase();
      await CacheHelper.saveData(
          key: "password", value: passwordController.text);

      emit(state.copyWith(signUpHospitalState: RequestState.success));
    } on AuthException catch (e) {
      emit(state.copyWith(
          signUpHospitalState: RequestState.error, errorMessage: e.message));
    } on StorageException catch (e) {
      emit(state.copyWith(
          signUpHospitalState: RequestState.error, errorMessage: e.message));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
          signUpHospitalState: RequestState.error, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          signUpHospitalState: RequestState.error,
          errorMessage: "An unexpected error occurred"));
    }
  }

  //
  Future addHospitalToDatabase() async {
    try {
      final hospitalUID = await signupAuthHospital();
      final docsUrl = await uploadDocs();
      final hospitalModel = _createHospitalSignupModel(
          hospitalUID!.user!.id.toString(), docsUrl!);
      await Supabase.instance.client
          .from("HospitalAuth")
          .insert(hospitalModel.toMap());
    } on StorageException catch (e) {
      throw StorageException(e.message);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.code!);
    }
  }

  HospitalSignupModel _createHospitalSignupModel(
      String hospitalUID, String docsUrl) {
    final phonePrimartCode =
        state.selectedPhoneServicePrimaryContactPerson == 'Orange'
            ? '077'
            : state.selectedPhoneServicePrimaryContactPerson == 'Zain'
                ? '079'
                : state.selectedPhoneServicePrimaryContactPerson == 'Umniah'
                    ? '078'
                    : '077';
    final phoneCode = state.selectedPhoneService == 'Orange'
        ? '077'
        : state.selectedPhoneService == 'Zain'
            ? '079'
            : state.selectedPhoneService == 'Umniah'
                ? '078'
                : '077';
    return HospitalSignupModel(
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
      phone: "${phoneCode}${phoneController.text}",
      latitude: _parseDouble(latitudeController.text),
      longitude: _parseDouble(longitudeController.text),
      primaryContactPerson:
          "${phonePrimartCode}${primaryContactPersonController.text}",
      currentLocation: currentLocationController.text,
      dayes: state.selectedDays,
      openingTime: '${state.openingTime!.hour}:${state.openingTime!.minute}',
      // openingTime: state.openingTime,
      closingTime: '${state.closingTime!.hour}:${state.closingTime!.minute}',
      // closingTime: state.closingTime,
      docsFile: docsUrl,
      uId: hospitalUID,
    );
  }

  Future<AuthResponse?> signupAuthHospital() async {
    try {
      return await Supabase.instance.client.auth.signUp(
          password: passwordController.text,
          email: emailController.text,
          data: {"roule": "hospital"});
    } on AuthException catch (e) {
      print(e);
      throw AuthException(e.message);
    }
  }

  Future<String?> uploadDocs() async {
    try {
      final uniqueFileName =
          "${DateTime.now().microsecondsSinceEpoch}_${state.selectedDocsFiles[0].path.split("/").last}";
      final response = await Supabase.instance.client.storage
          .from('hospital_docs')
          .upload(uniqueFileName, state.selectedDocsFiles[0]);
      return await Supabase.instance.client.storage
          .from("hospital_docs")
          .getPublicUrl(response.split("/").last);
    } on StorageException catch (e) {
      throw StorageException(e.message);
    }
  }

  //SignUp data

  //SignUp data
  toggleServicePhone(String phoneService) {
    emit(state.copyWith(selectedPhoneService: phoneService));
  }

  toggleServicePhonePrimaryContactNumber(String phoneService) {
    emit(
        state.copyWith(selectedPhoneServicePrimaryContactPerson: phoneService));
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

  selectClosingTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 23, minute: 0),
    );
    if (picked != null) emit(state.copyWith(closingTime: picked));
  }

  toggleIsSecure() {
    emit(state.copyWith(isObSecure: !state.isObSecure));
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

  double _parseDouble(String value) {
    return double.tryParse(value) ?? 0.0;
  }
}
