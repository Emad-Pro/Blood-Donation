// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_send_appointment_cubit.dart';

class UserSendAppointmentState extends Equatable {
  final String? selectedTimeBloodDonationAppointment;
  final String? selectedDayBloodDonationAppointment;
  final RequestState sendRequestAppointmentState;

  final String? errorMessage;
  UserSendAppointmentState({
    this.selectedTimeBloodDonationAppointment,
    this.selectedDayBloodDonationAppointment,
    this.sendRequestAppointmentState = RequestState.init,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        selectedTimeBloodDonationAppointment,
        selectedDayBloodDonationAppointment,
        sendRequestAppointmentState,
        errorMessage,
      ];

  UserSendAppointmentState copyWith({
    String? selectedTimeBloodDonationAppointment,
    String? selectedDayBloodDonationAppointment,
    RequestState? sendRequestAppointmentState,
    String? errorMessage,
  }) {
    return UserSendAppointmentState(
      selectedTimeBloodDonationAppointment:
          selectedTimeBloodDonationAppointment ??
              this.selectedTimeBloodDonationAppointment,
      selectedDayBloodDonationAppointment:
          selectedDayBloodDonationAppointment ??
              this.selectedDayBloodDonationAppointment,
      sendRequestAppointmentState:
          sendRequestAppointmentState ?? this.sendRequestAppointmentState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
