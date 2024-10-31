import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../../../core/location_service/location_service.dart';

part 'user_signup_state.dart';

class UserSignupCubit extends Cubit<UserSignupState> {
  UserSignupCubit(this._locationService) : super(UserSignupState()) {}
  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  final List<String> genderTypes = ['Male', 'Female', 'Other'];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateLastBloodDonationController =
      TextEditingController();
  TextEditingController currentLocationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  final LocationService _locationService;

  toggleSelectedBloodType(String bloodType) {
    emit(state.copyWith(selectedBloodType: bloodType));
  }

  toggleSelectedGender(String gender) {
    emit(state.copyWith(selectedGender: gender));
  }

  void toggleDiseaseSelection(String disease) {
    final updatedDiseases = Map<String, bool>.from(state.diseases);
    updatedDiseases[disease] = !updatedDiseases[disease]!;
    emit(state.copyWith(diseases: updatedDiseases));
  }

  void toggleIsDisease() {
    bool isDisease = state.diseases.values.any((isSelected) => isSelected);
    if (isDisease) {
      emit(state.copyWith(isDisease: true));
    } else {
      emit(state.copyWith(isDisease: false));
    }
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
    } catch (e) {
      emit(state.copyWith(
          permissionRequestState: RequestState.error,
          permissionMessage: "Filed to get location"));
    }
  }
}
