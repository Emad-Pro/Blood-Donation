// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_give_reward_for_request_donation_cubit.dart';

class HospitalGiveRewardForRequestDonationState extends Equatable {
  const HospitalGiveRewardForRequestDonationState(
      {this.getAcceptedRequestsState = RequestState.init,
      this.confirmRequestState = RequestState.init,
      this.getAcceptedRequestsMessage = '',
      this.getAcceptedRequestsModel});
  final RequestState getAcceptedRequestsState;
  final String getAcceptedRequestsMessage;
  final List<HospitalDonorReceviedRequestsModel>? getAcceptedRequestsModel;

  final RequestState confirmRequestState;
  @override
  List<Object?> get props => [
        getAcceptedRequestsState,
        getAcceptedRequestsMessage,
        confirmRequestState,
        getAcceptedRequestsModel
      ];

  HospitalGiveRewardForRequestDonationState copyWith({
    RequestState? getAcceptedRequestsState,
    String? getAcceptedRequestsMessage,
    List<HospitalDonorReceviedRequestsModel>? getAcceptedRequestsModel,
    RequestState? confirmRequestState,
  }) {
    return HospitalGiveRewardForRequestDonationState(
      getAcceptedRequestsState:
          getAcceptedRequestsState ?? this.getAcceptedRequestsState,
      getAcceptedRequestsMessage:
          getAcceptedRequestsMessage ?? this.getAcceptedRequestsMessage,
      getAcceptedRequestsModel:
          getAcceptedRequestsModel ?? this.getAcceptedRequestsModel,
      confirmRequestState: confirmRequestState ?? RequestState.init,
    );
  }
}
