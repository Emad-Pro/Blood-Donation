// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_main_cubit.dart';

class UserMainState extends Equatable {
  final int currentIndex;

  const UserMainState({
    this.currentIndex = 0,
  });

  @override
  List<Object> get props => [currentIndex];

  UserMainState copyWith({
    int? currentIndex,
  }) {
    return UserMainState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
