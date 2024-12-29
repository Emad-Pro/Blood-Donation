// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_appointment_cubit.dart';

class MyAppointmentState extends Equatable {
  final List<MyAppointmentModel>? appointments;
  final RequestState appointmentsState;
  final String errorMessage;
  final RequestState appointmentsDeleteState;
  final String appointmentsDeleteErrorMessage;
  const MyAppointmentState(
      {this.appointments,
      this.appointmentsState = RequestState.init,
      this.errorMessage = '',
      this.appointmentsDeleteState = RequestState.init,
      this.appointmentsDeleteErrorMessage = ''});

  @override
  List<Object?> get props => [
        appointments,
        appointmentsState,
        errorMessage,
        appointmentsDeleteState,
        appointmentsDeleteErrorMessage
      ];

  MyAppointmentState copyWith(
      {List<MyAppointmentModel>? appointments,
      RequestState? appointmentsState,
      String? errorMessage,
      RequestState? appointmentsDeleteState,
      String? appointmentsDeleteErrorMessage}) {
    return MyAppointmentState(
      appointments: appointments ?? this.appointments,
      appointmentsState: appointmentsState ?? this.appointmentsState,
      errorMessage: errorMessage ?? this.errorMessage,
      appointmentsDeleteState: appointmentsDeleteState ?? RequestState.init,
      appointmentsDeleteErrorMessage:
          appointmentsDeleteErrorMessage ?? this.appointmentsDeleteErrorMessage,
    );
  }
}
