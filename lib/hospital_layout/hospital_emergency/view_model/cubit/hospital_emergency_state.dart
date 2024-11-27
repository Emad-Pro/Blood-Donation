part of 'hospital_emergency_cubit.dart';

class HospitalEmergencyState extends Equatable {
  final Map<String, bool> bloodSelected;

  final String timeNeeded;
  final int locationDistance;
  final int unitsRequired;
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
      this.timeNeeded = '',
      this.locationDistance = 0,
      this.unitsRequired = 0});
  HospitalEmergencyState copyWith({
    Map<String, bool>? bloodSelected,
    String? timeNeeded,
    int? locationDistance,
    int? unitsRequired,
  }) {
    return HospitalEmergencyState(
      bloodSelected: bloodSelected ?? this.bloodSelected,
      timeNeeded: timeNeeded ?? this.timeNeeded,
      locationDistance: locationDistance ?? this.locationDistance,
      unitsRequired: unitsRequired ?? this.unitsRequired,
    );
  }

  @override
  List<Object> get props =>
      [bloodSelected, timeNeeded, locationDistance, unitsRequired];
}
