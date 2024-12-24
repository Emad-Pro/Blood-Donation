// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_find_hospital_cubit.dart';

class UserFindHospitalState extends Equatable {
  const UserFindHospitalState({
    this.selectedGovernorate,
    this.selectedNearby,
    this.selectedDay,
    this.hospitalsModel,
    this.hospitalsState = RequestState.init,
    this.searchState = RequestState.init,
    this.searchResult,
    this.errorMessage,
  });
  final String? selectedGovernorate;
  final int? selectedNearby;
  final String? selectedDay;
  final List<HospitalProfileModel>? hospitalsModel;
  final RequestState hospitalsState;
  final String? errorMessage;
  final List<HospitalProfileModel>? searchResult;
  final RequestState searchState;

  @override
  List<Object?> get props => [
        selectedGovernorate,
        selectedNearby,
        selectedDay,
        hospitalsModel,
        hospitalsState,
        errorMessage,
        searchResult,
        searchState,
      ];

  UserFindHospitalState copyWith({
    String? selectedGovernorate,
    int? selectedNearby,
    String? selectedDay,
    List<HospitalProfileModel>? hospitalsModel,
    RequestState? hospitalsState,
    String? errorMessage,
    RequestState? searchState,
    List<HospitalProfileModel>? searchResult,
  }) {
    return UserFindHospitalState(
      selectedGovernorate: selectedGovernorate ?? this.selectedGovernorate,
      selectedNearby: selectedNearby ?? this.selectedNearby,
      selectedDay: selectedDay ?? this.selectedDay,
      hospitalsModel: hospitalsModel ?? this.hospitalsModel,
      hospitalsState: hospitalsState ?? this.hospitalsState,
      errorMessage: errorMessage ?? this.errorMessage,
      searchResult: searchResult ?? this.searchResult,
      searchState: searchState ?? RequestState.init,
    );
  }

  UserFindHospitalState clearFiled(
      {String? selectedGovernorate,
      int? selectedNearby,
      String? selectedDay,
      List<HospitalProfileModel>? hospitalsModel,
      RequestState? hospitalsState,
      String? errorMessage,
      RequestState? searchState,
      List<HospitalProfileModel>? searchResult,
      String? selectedTime,
      String? selectedTimeBloodDonationAppointment,
      RequestState? sendRequestAppointmentState}) {
    return UserFindHospitalState(
      selectedGovernorate: selectedGovernorate,
      selectedNearby: selectedNearby,
      selectedDay: selectedDay,
      hospitalsModel: hospitalsModel ?? this.hospitalsModel,
      hospitalsState: hospitalsState ?? this.hospitalsState,
      errorMessage: errorMessage ?? this.errorMessage,
      searchResult: searchResult ?? this.searchResult,
      searchState: searchState ?? RequestState.init,
    );
  }
}
