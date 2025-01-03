// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final RequestState forgotPasswordState;
  final String errorMessage;
  final RequestState otpState;
  final String otpMessage;
  final AuthResponse? authResponse;
  final RequestState resetPasswordState;
  final String resetPasswordMessage;
  final bool isSecure;
  const ForgotPasswordState(
      {this.forgotPasswordState = RequestState.init,
      this.errorMessage = '',
      this.resetPasswordState = RequestState.init,
      this.resetPasswordMessage = '',
      this.otpState = RequestState.init,
      this.otpMessage = '',
      this.isSecure = true,
      this.authResponse});

  @override
  List<Object?> get props => [
        errorMessage,
        forgotPasswordState,
        resetPasswordState,
        resetPasswordMessage,
        otpState,
        otpMessage,
        authResponse,
        isSecure
      ];

  ForgotPasswordState copyWith(
      {RequestState? forgotPasswordState,
      String? errorMessage,
      RequestState? resetPasswordState,
      String? resetPasswordMessage,
      RequestState? otpState,
      String? otpMessage,
      AuthResponse? authResponse,
      bool? isSecure}) {
    return ForgotPasswordState(
        forgotPasswordState: forgotPasswordState ?? RequestState.init,
        errorMessage: errorMessage ?? this.errorMessage,
        resetPasswordState: resetPasswordState ?? RequestState.init,
        resetPasswordMessage: resetPasswordMessage ?? this.resetPasswordMessage,
        otpState: otpState ?? RequestState.init,
        otpMessage: otpMessage ?? this.otpMessage,
        authResponse: authResponse ?? this.authResponse,
        isSecure: isSecure ?? this.isSecure);
  }
}
