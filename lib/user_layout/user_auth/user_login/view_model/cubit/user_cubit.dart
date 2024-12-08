import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/shared_preferences/cache_helper.dart';
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
    try {
      emit(state.copyWith(loginState: RequestState.loading));
      final response = await Supabase.instance.client.auth.signInWithPassword(
          email: emailController.text, password: passwordController.text);
      if (response.user!.identities!.first.identityData!['roule'] == 'user') {
        await CacheHelper.saveData(
            key: "password", value: passwordController.text);
        emit(state.copyWith(loginState: RequestState.success));
      } else if (response.user!.identities!.first.identityData!['roule'] ==
          'hospital') {
        emit(state.copyWith(
            loginState: RequestState.error,
            errorMessage: "Authorization Error"));
      } else {
        emit(state.copyWith(
            loginState: RequestState.error,
            errorMessage: "Authorization Error"));
      }
    } on AuthException catch (e) {
      print(e.code);
      emit(
          state.copyWith(loginState: RequestState.error, errorMessage: e.code));
    }
  }
}
