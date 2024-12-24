import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'package:blood_donation/user_layout/user_profile/view_model/user_profile_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/location_service/location_service.dart';

part 'user_find_hospital_state.dart';

class UserFindHospitalCubit extends Cubit<UserFindHospitalState> {
  UserFindHospitalCubit() : super(UserFindHospitalState()) {
    getAllHospitals();
  }

/* This Filed For DropDown */
  final List<String> governorates = [
    "Amman",
    "Zarqa",
    "Irbid",
    "Balqa",
    "Madaba",
    "Karak",
    "Tafilah",
    "Maan",
    "Aqaba",
    "Jerash",
    "Ajloun",
    "Mafraq"
  ];
  final List<int> nearby = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  final List<String> dayWorking = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];
  TextEditingController nameController = TextEditingController();
  toggleDay(String day) => emit(state.copyWith(
      selectedGovernorate: state.selectedGovernorate,
      selectedNearby: state.selectedNearby,
      selectedDay: day));
  clearDayWorking() => emit(state.clearFiled(
      selectedDay: null,
      selectedGovernorate: state.selectedGovernorate,
      selectedNearby: state.selectedNearby));
  toggleNearby(int nearby) => emit(state.copyWith(
      selectedDay: state.selectedDay,
      selectedNearby: nearby,
      selectedGovernorate: state.selectedGovernorate));
  clearNearby() {
    emit(state.clearFiled(
        selectedDay: state.selectedDay,
        selectedNearby: null,
        selectedGovernorate: state.selectedGovernorate));
  }

  cleargovernorates() => emit(state.clearFiled(
      selectedGovernorate: null,
      selectedNearby: state.selectedNearby,
      selectedDay: state.selectedDay));
  toggleGovernorate(String governorate) => emit(state.copyWith(
      selectedDay: state.selectedDay,
      selectedGovernorate: governorate,
      selectedNearby: state.selectedNearby));

/* This Filed For DropDown */

  getAllHospitals() async {
    emit(state.copyWith(hospitalsState: RequestState.loading));
    try {
      final response =
          await Supabase.instance.client.from("HospitalAuth").select();
      emit(state.copyWith(
          hospitalsState: RequestState.success,
          hospitalsModel:
              response.map((e) => HospitalProfileModel.fromMap(e)).toList()));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
          hospitalsState: RequestState.error, errorMessage: e.message));
    }
  }

  /* Search Method */
  searchWithAllFilters() async {
    emit(state.copyWith(searchState: RequestState.loading));

    // احصل على قائمة المستشفيات الحالية
    List<HospitalProfileModel> hospitals = state.hospitalsModel ?? [];

    // تطبيق تصفية حسب الموقع إذا تم تحديده
    if (state.selectedNearby != null && state.selectedNearby! > 0) {
      final userCubit = getIt<UserProfileCubit>().state.userSignupModel;
      if (userCubit != null &&
          userCubit.latitude != null &&
          userCubit.longitude != null) {
        hospitals = LocationService().filterLocationsByDistance(
            userCubit.longitude!,
            userCubit.latitude!,
            state.selectedNearby!.toDouble(),
            hospitals);
      }
    }

    // تطبيق تصفية حسب اليوم إذا تم تحديده
    if (state.selectedDay != null && state.selectedDay!.isNotEmpty) {
      hospitals = hospitals
          .where((hospital) =>
              hospital.dayes != null &&
              hospital.dayes!.contains(state.selectedDay!))
          .toList();
    }

    // تطبيق تصفية حسب المحافظة إذا تم تحديدها
    if (state.selectedGovernorate != null &&
        state.selectedGovernorate!.isNotEmpty) {
      hospitals = hospitals
          .where((hospital) =>
              hospital.currentLocation != null &&
              hospital.currentLocation!
                  .contains("${state.selectedGovernorate}"))
          .toList();
    }

    // تطبيق تصفية حسب الاسم إذا تم إدخال قيمة
    if (nameController.text.isNotEmpty) {
      hospitals = hospitals
          .where((hospital) =>
              hospital.name != null &&
              hospital.name!
                  .toLowerCase()
                  .contains(nameController.text.toLowerCase()))
          .toList();
    }

    // تحديث الحالة بالنتائج
    emit(state.copyWith(
        searchState: RequestState.success, searchResult: hospitals));
  }
}
