import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/app/public/choose_screen/view/choose_screen.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/methods/send_notification.dart';
import 'package:blood_donation/hospital_layout/hospital_profile_screen/view_model/cubit/hospital_profile_cubit.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/model/user_signup_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../../core/enum/request_state.dart';
import '../../../../core/methods/calculate_distance.dart';

part 'hospital_emergency_state.dart';

class HospitalEmergencyCubit extends Cubit<HospitalEmergencyState> {
  HospitalEmergencyCubit() : super(HospitalEmergencyState());
  getUsersData() async {
    emit(state.copyWith(usersState: RequestState.loading));
    try {
      Supabase.instance.client
          .from("UserAuth")
          .stream(primaryKey: ["id"]).listen((data) {
        emit(state.copyWith(
            userSignupModel:
                data.map((e) => UserSignupModel.fromJson(e)).toList(),
            usersState: RequestState.success));
      });
    } on PostgrestException catch (e) {
      emit(state.copyWith(usersState: RequestState.error));
    }
  }

  List<UserSignupModel> filtersUsersByBloodType() {
    // قم بإنشاء قائمة فارغة لتخزين المستخدمين المطابقين
    List<UserSignupModel> filteredUsers = [];

    // اجمع المستخدمين المطابقين لكل فصيلة دم محددة
    state.bloodSelected.entries.forEach((element) {
      if (element.value == true) {
        filteredUsers.addAll(
          state.userSignupModel!
              .where((user) => user.selectedBloodType == element.key)
              .toList(),
        );
      }
    });

    // إزالة التكرارات إذا كانت موجودة
    filteredUsers = filteredUsers.toSet().toList();

    return filteredUsers;
  }

  void filterUsers() async {
    emit(state.copyWith(searchUserState: RequestState.loading));
    await getIt<HospitalProfileCubit>().getInfo();
    List<UserSignupModel> filteredUsers = [];
    final resultFilterByBlood = filtersUsersByBloodType();

    resultFilterByBlood.forEach((user) {
      int monthsDiff = calculateMonthsDifference(user.dateLastBloodDonation!);

      // افترض أن user يحتوي على إحداثيات المتبرع lat و lon
      double distance = calculateDistance(
          getIt<HospitalProfileCubit>().state.hospitalProfileModel!.latitude!,
          getIt<HospitalProfileCubit>().state.hospitalProfileModel!.longitude!,
          user.latitude!,
          user.longitude!);

      if (monthsDiff >= 3 && distance <= 10) {
        print(user.fullName);
        filteredUsers.add(user);
      }
    });
    emit(state.copyWith(
        searchUserResult: filteredUsers,
        searchUserState: RequestState.success));
  }

  int calculateMonthsDifference(DateTime startDate) {
    DateTime today = DateTime.now();
    int yearsDiff = today.year - startDate.year;
    int monthsDiff = today.month - startDate.month;

    int totalMonths = (yearsDiff * 12) + monthsDiff;

    if (today.day < startDate.day) {
      totalMonths--;
    }

    return totalMonths;
  }

  sendEmergencyRequest(BuildContext context, List<String> ids) async {
    emit(state.copyWith(
        sendEmergencyRequestNotificationState: RequestState.loading));
    try {
      await getIt<HospitalProfileCubit>().getInfo();
      List<String> bloodNames = [];
      state.bloodSelected.entries.forEach((element) {
        if (element.value == true) {
          bloodNames.add(element.key);
        }
      });
      sendNotification(
        contents:
            "${getIt<HospitalProfileCubit>().state.hospitalProfileModel!.name} We Need Emergency Blood Type ${bloodNames.join(', ')} ${state.timeNeeded!.trEn(context)} Units Count :${state.unitsRequired}",
        headings: "Emergency Blood Request",
        recivedIds: ids,
        contentAr:
            "${getIt<HospitalProfileCubit>().state.hospitalProfileModel!.name}نحتاج لطلب تبرع بالدم نوع ${bloodNames.join(', ')} ${state.timeNeeded!.trAr(context)} وحدات :${state.unitsRequired}",
        headingAr: "طلب تبرع عاجل بالدم",
      );
      emit(state.copyWith(
        sendEmergencyRequestNotificationState: RequestState.success,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
          sendEmergencyRequestNotificationState: RequestState.error));
    }
  }

  clearFileds() {
    emit(state.clear(
      bloodSelected: Map.from({
        'A+': false,
        'A-': false,
        'B+': false,
        'B-': false,
        'AB+': false,
        'AB-': false,
        'O+': false,
        'O-': false,
      }),
      timeNeeded: null,
      locationDistance: null,
      unitsRequired: null,
    ));
    bloodSelectedController.text = "";
  }

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
