part of 'user_home_cubit.dart';

class UserHomeState extends Equatable {
  final RequestState userPointState;
  final UserPointModel? userPointModel;
  final String errorMessage;

  UserHomeState(
      {this.userPointState = RequestState.init,
      this.userPointModel,
      this.errorMessage = ""});

  UserHomeState copyWith({
    RequestState? userPointState,
    UserPointModel? userPointModel,
    String? errorMessage,
  }) {
    return UserHomeState(
      userPointState: userPointState ?? this.userPointState,
      userPointModel: userPointModel ?? this.userPointModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [userPointState, userPointModel, errorMessage];
}
