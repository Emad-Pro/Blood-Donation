// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_profile_cubit.dart';

class UserProfileState extends Equatable {
  final RequestState userProfileState;
  final UserSignupModel? userSignupModel;
  final String errorMessage;

  UserProfileState(
      {this.userProfileState = RequestState.init,
      this.userSignupModel,
      this.errorMessage = ''});

  @override
  List<Object?> get props => [userProfileState, userSignupModel, errorMessage];

  UserProfileState copyWith({
    RequestState? userProfileState,
    UserSignupModel? userSignupModel,
    String? errorMessage,
  }) {
    return UserProfileState(
      userProfileState: userProfileState ?? this.userProfileState,
      userSignupModel: userSignupModel ?? this.userSignupModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
