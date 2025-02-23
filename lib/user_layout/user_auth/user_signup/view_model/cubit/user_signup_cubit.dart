import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/model/user_signup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/enum/request_state.dart';
import '../../../../../core/location_service/location_service.dart';

part 'user_signup_state.dart';

class UserSignupCubit extends Cubit<UserSignupState> {
  UserSignupCubit(this._locationService) : super(UserSignupState()) {}
  final LocationService _locationService;
  final List<String> nameServicePhone = ["Orange", "Zain", "Umniah"];
  final supabase = Supabase.instance.client;
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

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateLastBloodDonationController =
      TextEditingController();
  DateTime? lastDonation;
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneCodeController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController currentLocationController = TextEditingController();

  // SignUp Auth
  Future<void> signupUserWithEmailAndPassword() async {
    emit(state.copyWith(signUpState: RequestState.loading));
    try {
      final userAuth = await supabase.auth.signUp(
        password: passwordController.text,
        email: emailController.text,
        data: {'roule': 'user'},
      );
      ;

      await _addUserToDatabase(userAuth);

      emit(state.copyWith(signUpState: RequestState.success));
    } on AuthException catch (e) {
      emit(state.copyWith(
          signUpState: RequestState.error, errorMessage: e.message));
    } on StorageException catch (e) {
      emit(state.copyWith(
          signUpState: RequestState.error, errorMessage: e.message));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
          signUpState: RequestState.error, errorMessage: e.message));
    } catch (e) {
      print("aaaaaaaaaaaaaaaaaaaaaa${e}");
      emit(state.copyWith(
          signUpState: RequestState.error,
          errorMessage: "An unexpected error occurred"));
    }
  }

  Future<void> _addUserToDatabase(AuthResponse userAuth) async {
    try {
      final String? imageUrl;
      if (state.selectedProfileImage != null) {
        imageUrl = await _uploadProfileImage();
      } else {
        imageUrl = null;
      }

      final userModel = _createUserSignupModel(userAuth.user!.id, imageUrl);
      await supabase.from("UserAuth").insert(userModel.toJson());
      await supabase
          .from("donation_point")
          .insert({"uId": userAuth.user!.id, "point": 0});
    } on StorageException catch (e) {
      print(e.message);
      throw StorageException(e.message);
    } on PostgrestException catch (e) {
      throw PostgrestException(message: e.code!);
    }
  }

  Future<String?> _uploadProfileImage() async {
    try {
      final uniqueFileName =
          "${DateTime.now().microsecondsSinceEpoch}_${state.selectedProfileImage!.path.split("/").last}";
      final response = await supabase.storage
          .from('users_images_profile')
          .upload(uniqueFileName, state.selectedProfileImage!);

      return await supabase.storage
          .from('users_images_profile')
          .getPublicUrl(response.split("/").last);
    } on StorageException catch (e) {
      throw StorageException(e.message);
    }
  }

  UserSignupModel _createUserSignupModel(String userId, String? imageUrl) {
    return UserSignupModel(
      email: emailController.text,
      fullName: fullNameController.text,
      dateLastBloodDonation:
          DateTime.parse(dateLastBloodDonationController.text),
      phone:
          "${state.selectedPhoneService == 'Orange' ? '077' : state.selectedPhoneService == 'Zain' ? '079' : state.selectedPhoneService == 'Umniah' ? '078' : '077'}${phoneController.text}",
      phoneCode: phoneCodeController.text,
      age: ageController.text,
      height: _parseInt(heightController.text),
      weight: _parseInt(weightController.text),
      latitude: _parseDouble(latitudeController.text),
      longitude: _parseDouble(longitudeController.text),
      currentLocation: currentLocationController.text,
      selectedBloodType: state.selectedBloodType,
      selectedGender: state.selectedGender,
      diseases: state.diseases,
      isDisease: state.isDisease,
      uId: userId,
      profileImage: imageUrl ?? '',
    );
  }

  int _parseInt(String value) {
    return int.tryParse(value) ?? 0;
  }

  double _parseDouble(String value) {
    return double.tryParse(value) ?? 0.0;
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
