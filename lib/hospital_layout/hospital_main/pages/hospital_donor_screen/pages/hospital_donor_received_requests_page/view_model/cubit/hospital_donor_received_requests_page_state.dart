// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_donor_received_requests_page_cubit.dart';

class HospitalDonorReceivedRequestsState extends Equatable {
  final RequestState hospitaldonorReceivedState;
  final List<HospitalDonorReceviedRequestsModel>?
      hospitalDonorReceviedRequestsModel;
  final String errorMessage;

  HospitalDonorReceivedRequestsState(
      {this.hospitaldonorReceivedState = RequestState.init,
      this.hospitalDonorReceviedRequestsModel,
      this.errorMessage = ''});
  @override
  List<Object?> get props => [
        hospitaldonorReceivedState,
        hospitalDonorReceviedRequestsModel,
        errorMessage,
      ];

  HospitalDonorReceivedRequestsState copyWith(
      {RequestState? hospitaldonorReceivedState,
      String? errorMessage,
      List<HospitalDonorReceviedRequestsModel>?
          hospitalDonorReceviedRequestsModel}) {
    return HospitalDonorReceivedRequestsState(
        hospitaldonorReceivedState:
            hospitaldonorReceivedState ?? this.hospitaldonorReceivedState,
        errorMessage: errorMessage ?? this.errorMessage,
        hospitalDonorReceviedRequestsModel:
            hospitalDonorReceviedRequestsModel ??
                this.hospitalDonorReceviedRequestsModel);
  }
}
