import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/model/user_signup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../../../core/location_service/location_service.dart';

part 'user_signup_state.dart';

class UserSignupCubit extends Cubit<UserSignupState> {
  UserSignupCubit(this._locationService) : super(UserSignupState()) {}
  final LocationService _locationService;
  final List<String> nameServicePhone = ["Orange", "Zain", "Omniah"];

  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
    "I don't know"
  ];
  final List<String> genderTypes = ['Male', 'Female', 'Other'];

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateLastBloodDonationController =
      TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneCodeController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();
  fetchLoginData() async {
    UserSignupModel userSignupModel = UserSignupModel(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      fullName: fullNameController.text,
      dateLastBloodDonation: dateLastBloodDonationController.text,
      phone: phoneController.text,
      phoneCode: phoneCodeController.text,
      age: ageController.text,
      height: heightController.text,
      weight: weightController.text,
      latitude: latitudeController.text,
      longitude: longitudeController.text,
      currentLocation: currentLocationController.text,
      selectedBloodType: state.selectedBloodType,
      selectedGender: state.selectedGender,
      diseases: state.diseases,
      isDisease: state.isDisease,
      selectedProfileImage: state.slectedProfileImage,
    );
    print(userSignupModel.toJson());
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      emit(state.copyWith(slectedProfileImage: imageTemp));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future takeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      emit(state.copyWith(slectedProfileImage: imageTemp));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  togglePasswordSecure() {
    emit(state.copyWith(isSecure: !state.isSecure));
  }

  toggleServicePhone(String phoneService) {
    emit(state.copyWith(selectedPhoneService: phoneService));
  }

  toggleSelectedBloodType(String bloodType) {
    emit(state.copyWith(selectedBloodType: bloodType));
  }

  toggleSelectedGender(String gender) {
    emit(state.copyWith(selectedGender: gender));
  }

  toggleDiseaseSelection(String disease) {
    final updatedDiseases = Map<String, bool>.from(state.diseases);
    updatedDiseases[disease] = !updatedDiseases[disease]!;
    emit(state.copyWith(diseases: updatedDiseases));
  }

  toggleIsDisease() {
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
      emit(state.copyWith(permissionRequestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(
          permissionRequestState: RequestState.error,
          permissionMessage: "Filed to get location"));
    }
  }
}
