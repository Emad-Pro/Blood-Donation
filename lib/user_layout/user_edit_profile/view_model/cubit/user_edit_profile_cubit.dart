import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/location_service/location_service.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/model/user_signup_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_edit_profile_state.dart';

class UserEditProfileCubit extends Cubit<UserEditProfileState> {
  UserEditProfileCubit(this.userSignupModel, this._locationService)
      : super(UserEditProfileState()) {
    getData();
  }
  TextEditingController docsFileController = TextEditingController();
  TextEditingController primaryContactPersonController =
      TextEditingController();

  /// for Change Password

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final changePasswordKey = GlobalKey<FormState>();
  toggleShowNewPassowrd() {
    emit(state.copyWith(newPsswordIsSecure: !state.newPsswordIsSecure));
  }

  toggleShowOldPassowrd() {
    emit(state.copyWith(oldPasswordIsSecure: !state.oldPasswordIsSecure));
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

  final List<String> nameServicePhone = ["Orange", "Zain", "Umniah"];
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
  final List<String> genderTypes = ['Male', 'Female'];
  final UserSignupModel userSignupModel;
  final LocationService _locationService;
  final formKey = GlobalKey<FormState>();
  Future<String?> uploadImage() async {
    final supabase = await Supabase.instance.client.storage;
    emit(state.copyWith(
        upoladImageState: RequestState.loading,
        selectedProfileImage: state.selectedProfileImage));

    try {
      final uniqueFileName =
          "${DateTime.now().microsecondsSinceEpoch}_${state.selectedProfileImage!.path.split("/").last}";
      final result = await supabase
          .from("users_images_profile")
          .upload(uniqueFileName, state.selectedProfileImage!);
      emit(state.copyWith(upoladImageState: RequestState.success));
      return await supabase
          .from('users_images_profile')
          .getPublicUrl(result.split("/").last);
    } on StorageException catch (e) {
      throw StorageException(e.message);
    }
  }

  updateProfile() async {
    String? path;
    if (state.selectedProfileImage != null) {
      path = await uploadImage();
    }

    final model = UserSignupModel(
      id: userSignupModel.id,
      email: emailController.text,
      fullName: nameController.text,
      dateLastBloodDonation: lastDonationController.text,
      phoneCode: _getPhoneServiceWithName(state.selectedPhoneService!),
      phone: "${phoneController.text}",
      age: ageController.text,
      height: int.parse(heightController.text),
      weight: int.parse(weightController.text),
      latitude: double.parse(lateController.text),
      longitude: double.parse(longController.text),
      currentLocation: locationController.text,
      selectedBloodType: state.selectedBloodType,
      selectedGender: state.selectedGender,
      diseases: state.diseases,
      isDisease: state.isDisease,
      uId: userSignupModel.uId,
      profileImage: path == null ? userSignupModel.profileImage : path,
    );
    emit(state.copyWith(
      editProfileState: RequestState.loading,
      selectedProfileImage: state.selectedProfileImage,
    ));
    try {
      await Supabase.instance.client
          .from("UserAuth")
          .update(model.toJson())
          .eq("uId", userSignupModel.uId!);
      emit(state.copyWith(
          editProfileState: RequestState.success,
          selectedProfileImage: state.selectedProfileImage));
    } on PostgrestException catch (e) {
      //   print(e);
      emit(state.copyWith(
          editProfileState: RequestState.error,
          errorMessage: e.code,
          selectedProfileImage: state.selectedProfileImage));
    }
  }

  getData() {
    nameController.text = userSignupModel.fullName!;
    emailController.text = userSignupModel.email!;
    phoneController.text =
        userSignupModel.phone!.substring(3, userSignupModel.phone!.length);
    locationController.text = userSignupModel.currentLocation!;
    ageController.text = userSignupModel.age!.toString();
    weightController.text = userSignupModel.weight!.toString();
    heightController.text = userSignupModel.height!.toString();
    lateController.text = userSignupModel.latitude!.toString();
    longController.text = userSignupModel.longitude!.toString();
    lastDonationController.text = userSignupModel.dateLastBloodDonation!;
    emit(state.copyWith(
        imageProfile: userSignupModel.profileImage,
        selectedGender: userSignupModel.selectedGender,
        isDisease: userSignupModel.isDisease!,
        diseases: Map.from(userSignupModel.diseases!),
        selectedPhoneService: _getPhoneService(userSignupModel.phone!),
        selectedBloodType: userSignupModel.selectedBloodType));
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

  void deleteImage() {
    emit(state.copyWith(selectedProfileImage: null));
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      emit(state.copyWith(selectedProfileImage: imageTemp));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future takeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      emit(state.copyWith(selectedProfileImage: imageTemp));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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

  toggleDiseaseSelection(String disease) {
    final updatedDiseases = Map<String, bool>.from(state.diseases);
    updatedDiseases[disease] = !updatedDiseases[disease]!;
    emit(state.copyWith(
        diseases: updatedDiseases,
        selectedProfileImage: state.selectedProfileImage));
  }

  toggleIsDisease() {
    bool isDisease = state.diseases.values.any((isSelected) => isSelected);
    if (isDisease) {
      emit(state.copyWith(
          isDisease: true, selectedProfileImage: state.selectedProfileImage));
    } else {
      emit(state.copyWith(
          isDisease: false, selectedProfileImage: state.selectedProfileImage));
    }
  }

  Future<void> getLocation() async {
    try {
      Position? position = await _locationService.getCurrentLocation();

      if (position == null) {
        emit(state.copyWith(
            permissionRequestState: RequestState.error,
            permissionMessage: "Acces Denied",
            selectedProfileImage: state.selectedProfileImage));
        return;
      }
      lateController.text = position.latitude.toString();
      longController.text = position.longitude.toString();

      print('خط العرض: ${position.latitude}, خط الطول: ${position.longitude}');

      String locationAddress =
          await _locationService.getAddressFromCoordinates(position);

      locationController.text = locationAddress;
      emit(state.copyWith(permissionRequestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(
          permissionRequestState: RequestState.error,
          permissionMessage: "Filed to get location",
          selectedProfileImage: state.selectedProfileImage));
    }
  }

  toggleBloodType(String type) {
    emit(state.copyWith(
        selectedBloodType: type,
        selectedProfileImage: state.selectedProfileImage));
  }

  toggleGender(String gender) {
    emit(state.copyWith(
        selectedGender: gender,
        selectedProfileImage: state.selectedProfileImage));
  }

  togglePhoneService(String service) {
    emit(state.copyWith(
        selectedPhoneService: service,
        selectedProfileImage: state.selectedProfileImage));
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController lateController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController lastDonationController = TextEditingController();
}
