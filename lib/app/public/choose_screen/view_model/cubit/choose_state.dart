part of 'choose_cubit.dart';

class ChooseState {
  final int selectedIndex;

  ChooseState({this.selectedIndex = 0});

  ChooseState copyWith({
    int? selectedIndex,
  }) {
    return ChooseState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
