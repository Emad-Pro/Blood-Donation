import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'hospital_login_state.dart';

class HospitalLoginCubit extends Cubit<HospitalLoginState> {
  HospitalLoginCubit() : super(HospitalLoginState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  toggleShowPassword() {
    emit(state.copyWith(
        hospitalPasswordIsSecure: !state.hospitalPasswordIsSecure));
  }

  toggleRememberMe() {
    emit(state.copyWith(hospitalRememberMe: !state.hospitalRememberMe));
  }

  hospitalSigninWithEmailAndPassword() async {
    try {
      emit(state.copyWith(loginState: RequestState.loading));
      await Supabase.instance.client.auth.signInWithPassword(
          password: passwordController.text, email: emailController.text);
      emit(state.copyWith(loginState: RequestState.success));
    } on AuthException catch (error) {
      emit(state.copyWith(
          loginState: RequestState.error, errorMessage: error.code));
    }
  }
}
