part of 'user_cubit.dart';

class UserLoginState {
  final bool userPasswordIsSecure;
  final bool userRememberMe;

  UserLoginState(
      {this.userPasswordIsSecure = false, this.userRememberMe = false});

  UserLoginState copyWith({bool? userPasswordIsSecure, bool? userRememberMe}) {
    return UserLoginState(
        userPasswordIsSecure: userPasswordIsSecure ?? this.userPasswordIsSecure,
        userRememberMe: userRememberMe ?? this.userRememberMe);
  }
}
