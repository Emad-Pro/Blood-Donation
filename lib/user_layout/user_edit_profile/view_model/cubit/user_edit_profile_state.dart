// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_edit_profile_cubit.dart';

class UserEditProfileState extends Equatable {
  final String? selectedPhoneService;
  final String? selectedGender;
  final String? selectedBloodType;
  final Map<String, bool> diseases;
  final bool? isDisease;
  final String? imageProfile;
  final RequestState permissionRequestState;
  final String? permissionMessage;
  final File? selectedProfileImage;
  final RequestState upoladImageState;
  final RequestState editProfileState;
  final String? errorMessage;

  final RequestState changePasswordState;
  final String? changePasswordMessage;

  final bool oldPasswordIsSecure;
  final bool newPsswordIsSecure;
  UserEditProfileState(
      {this.selectedPhoneService,
      this.selectedGender,
      this.selectedBloodType,
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
        "Well-Controlled Diabetes": false,
        "Hypertension": false,
        "Seasonal Allergies": false,
        "Asthma": false,
        "Thalassemia Minor": false,
        "Hypothyroidism/Hyperthyroidism": false,
        "Hereditary Hemochromatosis": false
      },
      this.permissionRequestState = RequestState.init,
      this.permissionMessage = '',
      this.isDisease,
      this.imageProfile,
      this.selectedProfileImage,
      this.upoladImageState = RequestState.init,
      this.editProfileState = RequestState.init,
      this.errorMessage,
      this.changePasswordState = RequestState.init,
      this.changePasswordMessage,
      this.oldPasswordIsSecure = true,
      this.newPsswordIsSecure = true});

  @override
  List<Object?> get props => [
        selectedPhoneService,
        selectedGender,
        selectedBloodType,
        diseases,
        isDisease,
        imageProfile,
        permissionRequestState,
        permissionMessage,
        selectedProfileImage,
        upoladImageState,
        editProfileState,
        errorMessage,
        changePasswordState,
        changePasswordMessage,
        oldPasswordIsSecure,
        newPsswordIsSecure
      ];

  UserEditProfileState copyWith({
    String? selectedPhoneService,
    String? selectedGender,
    String? selectedBloodType,
    Map<String, bool>? diseases,
    bool? isDisease,
    String? imageProfile,
    RequestState? permissionRequestState,
    String? permissionMessage,
    File? selectedProfileImage,
    RequestState? upoladImageState,
    RequestState? editProfileState,
    String? errorMessage,
    RequestState? changePasswordState,
    String? changePasswordMessage,
    bool? oldPasswordIsSecure,
    bool? newPsswordIsSecure,
  }) {
    return UserEditProfileState(
        selectedPhoneService: selectedPhoneService ?? this.selectedPhoneService,
        selectedGender: selectedGender ?? this.selectedGender,
        selectedBloodType: selectedBloodType ?? this.selectedBloodType,
        diseases: diseases ?? this.diseases,
        isDisease: isDisease ?? this.isDisease,
        imageProfile: imageProfile ?? this.imageProfile,
        permissionRequestState:
            permissionRequestState ?? this.permissionRequestState,
        permissionMessage: permissionMessage ?? this.permissionMessage,
        selectedProfileImage: selectedProfileImage,
        upoladImageState: upoladImageState ?? this.upoladImageState,
        editProfileState: editProfileState ?? this.editProfileState,
        errorMessage: errorMessage ?? this.errorMessage,
        changePasswordState: changePasswordState ?? this.changePasswordState,
        changePasswordMessage:
            changePasswordMessage ?? this.changePasswordMessage,
        oldPasswordIsSecure: oldPasswordIsSecure ?? this.oldPasswordIsSecure,
        newPsswordIsSecure: newPsswordIsSecure ?? this.newPsswordIsSecure);
  }
}
