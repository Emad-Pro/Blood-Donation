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
}
