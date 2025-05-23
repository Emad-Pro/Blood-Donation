import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_donor_screen/hospital_donar_screen.dart';
import 'package:blood_donation/hospital_layout/hospital_home_screen/view/hospital_home_screen.dart';
import 'package:blood_donation/hospital_layout/hospital_profile_screen/view/hospital_profile_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'hospital_main_state.dart';

class HospitalMainCubit extends Cubit<HospitalMainState> {
  HospitalMainCubit() : super(HospitalMainState());
  final List<Widget> screens = [
    HospitalHomeScreen(),
    HospitalDonarScreen(),
    HospitalProfileScreen()
  ]; // For Screens

  final List<String> titles = ["Home", "Donations", "Profile"]; // For Appbar
  List<BottomNavigationBarItem> items(BuildContext context) => [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: "Home".tr(context)),
        BottomNavigationBarItem(
            icon: Icon(Icons.bloodtype), label: "Donors".tr(context)),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), label: "Profile".tr(context))
      ]; // For Bottom NavigationBar

  void changeIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
