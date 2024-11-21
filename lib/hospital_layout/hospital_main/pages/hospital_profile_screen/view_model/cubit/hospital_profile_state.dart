// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_profile_cubit.dart';

class HospitalProfileState extends Equatable {
  final RequestState hospitalProfileState;
  final HospitalProfileModel? hospitalProfileModel;
  final String? errorMessage;

  HospitalProfileState(
      {this.hospitalProfileState = RequestState.loading,
      this.hospitalProfileModel,
      this.errorMessage});

  @override
  List<Object?> get props =>
      [hospitalProfileModel, errorMessage, hospitalProfileState];

  HospitalProfileState copyWith({
    RequestState? hospitalProfileState,
    HospitalProfileModel? hospitalProfileModel,
    String? errorMessage,
  }) {
    return HospitalProfileState(
      hospitalProfileState: hospitalProfileState ?? this.hospitalProfileState,
      hospitalProfileModel: hospitalProfileModel ?? this.hospitalProfileModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
