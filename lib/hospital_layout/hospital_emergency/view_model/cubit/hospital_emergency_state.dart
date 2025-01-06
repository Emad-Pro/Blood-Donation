part of 'hospital_emergency_cubit.dart';

class HospitalEmergencyState {
  final Map<String, bool> bloodSelected;

  final String? timeNeeded;
  final int locationDistance;
  final int? unitsRequired;
  final RequestState usersState;
  final RequestState sendEmergencyRequestNotificationState;
  const HospitalEmergencyState(
      {this.bloodSelected = const {
        'A+': false,
        'A-': false,
        'B+': false,
        'B-': false,
        'AB+': false,
        'AB-': false,
        'O+': false,
        'O-': false
      },
      this.timeNeeded,
      this.usersState = RequestState.init,
      this.sendEmergencyRequestNotificationState = RequestState.init,
      this.locationDistance = 0,
      this.unitsRequired,
      this.userSignupModel,
      this.searchUserResult,
      this.searchUserState = RequestState.init});

  final List<UserSignupModel>? userSignupModel;
  final List<UserSignupModel>? searchUserResult;
  final RequestState searchUserState;

  HospitalEmergencyState copyWith(
      {Map<String, bool>? bloodSelected,
      String? timeNeeded,
      int? locationDistance,
      int? unitsRequired,
      List<UserSignupModel>? userSignupModel,
      RequestState? usersState,
      List<UserSignupModel>? searchUserResult,
      RequestState? searchUserState,
      RequestState? sendEmergencyRequestNotificationState}) {
    return HospitalEmergencyState(
        bloodSelected: bloodSelected ?? this.bloodSelected,
        timeNeeded: timeNeeded ?? this.timeNeeded,
        locationDistance: locationDistance ?? this.locationDistance,
        unitsRequired: unitsRequired ?? this.unitsRequired,
        userSignupModel: userSignupModel ?? this.userSignupModel,
        usersState: usersState ?? this.usersState,
        searchUserResult: searchUserResult ?? this.searchUserResult,
        searchUserState: searchUserState ?? RequestState.init,
        sendEmergencyRequestNotificationState:
            sendEmergencyRequestNotificationState ?? RequestState.init);
  }

  HospitalEmergencyState clear(
      {Map<String, bool>? bloodSelected,
      String? timeNeeded,
      int? locationDistance,
      int? unitsRequired,
      List<UserSignupModel>? userSignupModel,
      RequestState? usersState,
      List<UserSignupModel>? searchUserResult,
      RequestState? searchUserState,
      RequestState? sendEmergencyRequestNotificationState}) {
    return HospitalEmergencyState(
        bloodSelected: bloodSelected ?? this.bloodSelected,
        timeNeeded: timeNeeded,
        locationDistance: locationDistance ?? this.locationDistance,
        unitsRequired: unitsRequired,
        userSignupModel: userSignupModel ?? this.userSignupModel,
        usersState: usersState ?? this.usersState,
        searchUserResult: searchUserResult ?? this.searchUserResult,
        searchUserState: searchUserState ?? RequestState.init,
        sendEmergencyRequestNotificationState:
            sendEmergencyRequestNotificationState ?? RequestState.init);
  }
}
