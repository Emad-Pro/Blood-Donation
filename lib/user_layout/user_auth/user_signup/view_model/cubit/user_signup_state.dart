part of 'user_signup_cubit.dart';

class UserSignupState {
  final String? selectedBloodType;

  final String? selectedGender;

  final String permissionMessage;

  final RequestState permissionRequestState;

  final String? selectedPhoneService;
  final bool isSecure;
  final Map<String, bool> diseases;
  final bool isDisease;
  final File? slectedProfileImage;
  UserSignupState(
      {this.selectedBloodType,
      this.selectedGender,
      this.permissionMessage = '',
      this.selectedPhoneService,
      this.permissionRequestState = RequestState.init,
      this.slectedProfileImage,
      this.isDisease = false,
      this.isSecure = false,
      this.diseases = const {
        "HIV/AIDS": false,
        "Viral Hepatitis": false,
        "Tuberculosis": false,
        "Malaria": false,
        "Heart Diseases": false,
        "Cancer": false,
        "Uncontrolled Diabetes": false,
        "Chronic Kidney Disease": false,
        "Hereditary Blood Diseases": false,
      }});

  UserSignupState copyWith(
      {String? selectedBloodType,
      String? selectedGender,
      String? permissionMessage,
      RequestState? permissionRequestState,
      Map<String, bool>? diseases,
      bool? isDisease,
      File? slectedProfileImage,
      String? selectedPhoneService,
      bool? isSecure}) {
    return UserSignupState(
      selectedBloodType: selectedBloodType ?? this.selectedBloodType,
      selectedGender: selectedGender ?? this.selectedGender,
      permissionMessage: permissionMessage ?? this.permissionMessage,
      permissionRequestState:
          permissionRequestState ?? this.permissionRequestState,
      diseases: diseases ?? this.diseases,
      isDisease: isDisease ?? this.isDisease,
      slectedProfileImage: slectedProfileImage ?? this.slectedProfileImage,
      selectedPhoneService: selectedPhoneService ?? this.selectedPhoneService,
      isSecure: isSecure ?? this.isSecure,
    );
  }
}
