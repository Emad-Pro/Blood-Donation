part of 'user_cubit.dart';

class UserLoginState {
  final bool userPasswordIsSecure;
  final bool userRememberMe;
  final RequestState loginState;
  final String? errorMessage;

  UserLoginState(
      {this.userPasswordIsSecure = false,
      this.userRememberMe = false,
      this.errorMessage = '',
      this.loginState = RequestState.init});

  UserLoginState copyWith(
      {bool? userPasswordIsSecure,
      bool? userRememberMe,
      String? errorMessage,
      RequestState? loginState}) {
    return UserLoginState(
        userPasswordIsSecure: userPasswordIsSecure ?? this.userPasswordIsSecure,
        userRememberMe: userRememberMe ?? this.userRememberMe,
        errorMessage: errorMessage ?? this.errorMessage,
        loginState: loginState ?? this.loginState);
  }
}
