import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/shared_preferences/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../view/listener/user_login_listener.dart';

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

  signInWithEmailAndPassword(BuildContext context) async {
    try {
      emit(state.copyWith(loginState: RequestState.loading));
      final response = await Supabase.instance.client.auth.signInWithPassword(
          email: emailController.text, password: passwordController.text);
      print(response);
      if (response.user!.identities!.first.identityData!['roule'] == 'user') {
        await CacheHelper.saveData(
            key: "password", value: passwordController.text);

        var externalId = "${DateTime.now().millisecondsSinceEpoch.toString()}";

        await OneSignal.login(externalId);
        await Supabase.instance.client
            .from("UserAuth")
            .update({"onesignal_id": externalId}).eq("uId", response.user!.id);
        emit(state.copyWith(loginState: RequestState.success));
        loginUserDonerSuccess(context);
      } else if (response.user!.identities!.first.identityData!['roule'] ==
          'hospital') {
        await Supabase.instance.client.auth.signOut();
        loginUserDonerError(context, "You are not a user");
        emit(state.copyWith(loginState: RequestState.error));
      } else {
        emit(state.copyWith(loginState: RequestState.error));
        loginUserDonerError(context, "Authorization Error");
      }
    } on AuthException catch (e) {
      print(e.code);
      emit(state.copyWith(loginState: RequestState.error));
      loginUserDonerError(context, "Authorization Error");
    }
  }
}
