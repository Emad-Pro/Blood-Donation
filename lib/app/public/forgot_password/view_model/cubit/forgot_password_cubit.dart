import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordState());

  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassowordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKeyConfirmPassword = GlobalKey<FormState>();
  resetPassword() async {
    emit(state.copyWith(forgotPasswordState: RequestState.loading));
    try {
      await Supabase.instance.client.auth
          .resetPasswordForEmail(emailController.text)
          .then((onValue) {});
      emit(state.copyWith(forgotPasswordState: RequestState.success));
    } on AuthException catch (e) {
      emit(state.copyWith(
          forgotPasswordState: RequestState.error, errorMessage: e.message));
    }
  }

  toggleIsSecure() {
    emit(state.copyWith(isSecure: !state.isSecure));
  }

  Future<AuthResponse>? resetPasswordWithOtp() async {
    emit(state.copyWith(otpState: RequestState.loading));

    final supabaseAuth = Supabase.instance.client.auth;

    try {
      final otpResponse = await supabaseAuth.verifyOTP(
          email: emailController.text,
          token: otpController.text,
          type: OtpType.recovery);

      emit(state.copyWith(
          otpState: RequestState.success,
          otpMessage: "OTP verified successfully",
          authResponse: otpResponse));
      return otpResponse;
    } on AuthApiException catch (e) {
      emit(state.copyWith(otpState: RequestState.error, otpMessage: e.message));
      throw AuthApiException(e.message);
    } on AuthException catch (e) {
      emit(state.copyWith(otpState: RequestState.error, otpMessage: e.message));
      throw AuthException(e.message);
    } catch (e) {
      emit(state.copyWith(
          otpState: RequestState.error, otpMessage: e.toString()));
      throw AuthException(e.toString());
    }
  }

  Future<void> updateUserPassword(String accessToken) async {
    emit(state.copyWith(resetPasswordState: RequestState.loading));
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassowordController.text),
        emailRedirectTo: accessToken,
      );
      emit(state.copyWith(resetPasswordState: RequestState.success));
    } on AuthApiException catch (e) {
      emit(state.copyWith(
          resetPasswordState: RequestState.error, errorMessage: e.message));
    } on AuthException catch (e) {
      emit(state.copyWith(
          resetPasswordState: RequestState.error, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          resetPasswordState: RequestState.error, errorMessage: e.toString()));
    }
  }
}
