// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_give_rewards_emergency_cubit.dart';

class HospitalGiveRewardsEmergencyState extends Equatable {
  const HospitalGiveRewardsEmergencyState(
      {this.userModel,
      this.findUserState = RequestState.init,
      this.userGivePoint = RequestState.init});
  final UserSignupModel? userModel;
  final RequestState findUserState;
  final RequestState userGivePoint;
  @override
  List<Object?> get props => [userModel, findUserState, userGivePoint];

  HospitalGiveRewardsEmergencyState copyWith(
      {UserSignupModel? userModel,
      RequestState? findUserState,
      RequestState? userGivePoint}) {
    return HospitalGiveRewardsEmergencyState(
        userModel: userModel ?? this.userModel,
        findUserState: findUserState ?? this.findUserState,
        userGivePoint: userGivePoint ?? RequestState.init);
  }
}
