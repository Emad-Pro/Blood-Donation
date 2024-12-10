// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final RequestState forgotPasswordState;
  final String errorMessage;

  const ForgotPasswordState(
      {this.forgotPasswordState = RequestState.init, this.errorMessage = ''});

  @override
  List<Object> get props => [errorMessage, forgotPasswordState];

  ForgotPasswordState copyWith({
    RequestState? forgotPasswordState,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
