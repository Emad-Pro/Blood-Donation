part of 'hospital_signup_cubit.dart';

class HospitalSignupState {
  final List<String> selectedDays;
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;
  final List<File> selectedDocsFiles;
  final bool isObSecure;
  final String? selectedPhoneService;
  final List<String> daysOfWeek = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Select all'
  ];
  final RequestState permissionRequestState;
  final String? permissionMessage;
  HospitalSignupState({
    this.permissionRequestState = RequestState.init,
    this.permissionMessage,
    this.selectedDocsFiles = const [],
    this.selectedDays = const [],
    this.openingTime,
    this.closingTime,
    this.isObSecure = true,
    this.selectedPhoneService,
  });

  bool get allSelected => selectedDays.length == daysOfWeek.length - 1;

  HospitalSignupState copyWith({
    List<String>? selectedDays,
    TimeOfDay? openingTime,
    TimeOfDay? closingTime,
    RequestState? permissionRequestState,
    String? permissionMessage,
    List<File>? selectedDocsFiles,
    bool? isObSecure,
    String? selectedPhoneService,
  }) {
    return HospitalSignupState(
      selectedDays: selectedDays ?? this.selectedDays,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      permissionRequestState:
          permissionRequestState ?? this.permissionRequestState,
      permissionMessage: permissionMessage ?? this.permissionMessage,
      selectedDocsFiles: selectedDocsFiles ?? this.selectedDocsFiles,
      isObSecure: isObSecure ?? this.isObSecure,
      selectedPhoneService: selectedPhoneService ?? this.selectedPhoneService,
    );
  }
}
