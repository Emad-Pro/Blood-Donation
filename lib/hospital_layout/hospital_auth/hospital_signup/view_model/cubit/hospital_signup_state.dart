part of 'hospital_signup_cubit.dart';

class HospitalSignupState {
  final List<String> selectedDays;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;
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

  HospitalSignupState({
    required this.selectedDays,
    required this.openingTime,
    required this.closingTime,
  });

  bool get allSelected => selectedDays.length == daysOfWeek.length - 1;

  HospitalSignupState copyWith({
    List<String>? selectedDays,
    TimeOfDay? openingTime,
    TimeOfDay? closingTime,
  }) {
    return HospitalSignupState(
      selectedDays: selectedDays ?? this.selectedDays,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
    );
  }
}
