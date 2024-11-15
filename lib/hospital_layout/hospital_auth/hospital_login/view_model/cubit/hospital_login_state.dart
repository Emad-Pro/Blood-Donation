part of 'hospital_login_cubit.dart';

class HospitalLoginState {
  final bool hospitalPasswordIsSecure;
  final bool hospitalRememberMe;
  final RequestState loginState;
  final String? errorMessage;

  HospitalLoginState(
      {this.hospitalPasswordIsSecure = false,
      this.hospitalRememberMe = false,
      this.errorMessage = '',
      this.loginState = RequestState.init});

  HospitalLoginState copyWith(
      {bool? hospitalPasswordIsSecure,
      bool? hospitalRememberMe,
      String? errorMessage,
      RequestState? loginState}) {
    return HospitalLoginState(
        hospitalPasswordIsSecure:
            hospitalPasswordIsSecure ?? this.hospitalPasswordIsSecure,
        hospitalRememberMe: hospitalRememberMe ?? this.hospitalRememberMe,
        errorMessage: errorMessage ?? this.errorMessage,
        loginState: loginState ?? this.loginState);
  }
}
