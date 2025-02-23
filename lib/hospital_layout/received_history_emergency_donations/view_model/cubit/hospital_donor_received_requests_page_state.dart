// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_donor_received_requests_page_cubit.dart';

class HospitalDonorReceivedRequestsState extends Equatable {
  final RequestState hospitaldonorReceivedState;
  final List<HospitalDonorReceviedRequestsModel>?
      hospitalDonorReceviedRequestsModel;
  final String errorMessage;
  final RequestState updateAppointmentState;
  final RequestState historyAppointmentState;
  final List<HospitalDonorReceviedRequestsModel>?
      historyDonorReceviedRequestsModel;
  final List<HospitalEmergencyModel>? historyEmergencyDonorModel;
  final RequestState historyEmergencyDonorState;

  HospitalDonorReceivedRequestsState({
    this.hospitaldonorReceivedState = RequestState.init,
    this.hospitalDonorReceviedRequestsModel,
    this.errorMessage = '',
    this.updateAppointmentState = RequestState.init,
    this.historyDonorReceviedRequestsModel,
    this.historyAppointmentState = RequestState.init,
    this.historyEmergencyDonorModel,
    this.historyEmergencyDonorState = RequestState.init,
  });
  @override
  List<Object?> get props => [
        hospitaldonorReceivedState,
        hospitalDonorReceviedRequestsModel,
        errorMessage,
        updateAppointmentState,
        historyDonorReceviedRequestsModel,
        historyAppointmentState,
        historyEmergencyDonorModel,
        historyEmergencyDonorState,
      ];

  HospitalDonorReceivedRequestsState copyWith(
      {RequestState? hospitaldonorReceivedState,
      String? errorMessage,
      List<HospitalDonorReceviedRequestsModel>?
          hospitalDonorReceviedRequestsModel,
      RequestState? updateAppointmentState,
      RequestState? historyAppointmentState,
      List<HospitalDonorReceviedRequestsModel>?
          historyDonorReceviedRequestsModel,
      List<HospitalEmergencyModel>? historyEmergencyDonorModel,
      RequestState? historyEmergencyDonorState}) {
    return HospitalDonorReceivedRequestsState(
      updateAppointmentState: updateAppointmentState ?? RequestState.init,
      hospitaldonorReceivedState:
          hospitaldonorReceivedState ?? this.hospitaldonorReceivedState,
      errorMessage: errorMessage ?? this.errorMessage,
      hospitalDonorReceviedRequestsModel: hospitalDonorReceviedRequestsModel ??
          this.hospitalDonorReceviedRequestsModel,
      historyAppointmentState:
          historyAppointmentState ?? this.historyAppointmentState,
      historyDonorReceviedRequestsModel: historyDonorReceviedRequestsModel ??
          this.historyDonorReceviedRequestsModel,
      historyEmergencyDonorModel:
          historyEmergencyDonorModel ?? this.historyEmergencyDonorModel,
      historyEmergencyDonorState:
          historyEmergencyDonorState ?? this.historyEmergencyDonorState,
    );
  }
}
