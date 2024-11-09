import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit() : super(UserLoginState());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  toggleShowPassword() {
    emit(state.copyWith(userPasswordIsSecure: !state.userPasswordIsSecure));
  }

  toggleRememberME() {
    emit(state.copyWith(userRememberMe: !state.userRememberMe));
  }

  signInWithEmailAndPassword() async {
    emit(state.copyWith(loginState: RequestState.loading));
    try {
      await Supabase.instance.client.auth
          .signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((onValue) {
        print(onValue.user!.id);
      });
      emit(state.copyWith(loginState: RequestState.success));
    } on AuthException catch (e) {
      print(e.code);
      emit(
          state.copyWith(loginState: RequestState.error, errorMessage: e.code));
    }
  }
}
