// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_edit_profile_cubit.dart';

class HospitalEditProfileState extends Equatable {
  final TimeOfDay? openingTime;
  final TimeOfDay? closingTime;
  final List<String>? days;
  final String? selectedPhoneService;
  final String? selectedPhoneServicePrimaryContactPerson;
  final RequestState permissionRequestState;
  final String? permissionMessage;
  final RequestState updateProfileState;
  final String? updateProfileMessage;

  HospitalEditProfileState(
      {this.openingTime,
      this.closingTime,
      this.days = const [],
      this.selectedPhoneService,
      this.selectedPhoneServicePrimaryContactPerson,
      this.permissionRequestState = RequestState.init,
      this.permissionMessage,
      this.updateProfileState = RequestState.init,
      this.updateProfileMessage});

  @override
  List<Object?> get props => [
        openingTime,
        closingTime,
        days,
        selectedPhoneService,
        selectedPhoneServicePrimaryContactPerson,
        permissionRequestState,
        permissionMessage,
        updateProfileState,
        updateProfileMessage
      ];

  HospitalEditProfileState copyWith({
    TimeOfDay? openingTime,
    TimeOfDay? closingTime,
    List<String>? days,
    String? selectedPhoneService,
    String? selectedPhoneServicePrimaryContactPerson,
    RequestState? permissionRequestState,
    String? permissionMessage,
    RequestState? updateProfileState,
    String? updateProfileMessage,
  }) {
    return HospitalEditProfileState(
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      days: days ?? this.days,
      selectedPhoneService: selectedPhoneService ?? this.selectedPhoneService,
      selectedPhoneServicePrimaryContactPerson:
          selectedPhoneServicePrimaryContactPerson ??
              this.selectedPhoneServicePrimaryContactPerson,
      permissionRequestState:
          permissionRequestState ?? this.permissionRequestState,
      permissionMessage: permissionMessage ?? this.permissionMessage,
      updateProfileState: updateProfileState ?? this.updateProfileState,
      updateProfileMessage: updateProfileMessage ?? this.updateProfileMessage,
    );
  }

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
  bool get allSelected => days!.length == daysOfWeek.length - 1;
}