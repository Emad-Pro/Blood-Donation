// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_main_cubit.dart';

class HospitalMainState extends Equatable {
  const HospitalMainState({this.currentIndex = 0});
  final int currentIndex;

  @override
  List<Object> get props => [currentIndex];

  HospitalMainState copyWith({
    int? currentIndex,
  }) {
    return HospitalMainState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
