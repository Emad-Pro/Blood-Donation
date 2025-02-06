import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/shared_preferences/cache_helper.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_login/view/listener/hospital_login_listener.dart';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
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

  hospitalSigninWithEmailAndPassword(BuildContext context) async {
    try {
      emit(state.copyWith(loginState: RequestState.loading));
      final response = await Supabase.instance.client.auth.signInWithPassword(
          password: passwordController.text, email: emailController.text);
      if (response.user!.identities!.first.identityData!['roule'] ==
          'hospital') {
        await CacheHelper.saveData(
            key: "password", value: passwordController.text);

        var externalId =
            "${DateTime.now().millisecondsSinceEpoch.toString()}"; // You will supply the external id to the OneSignal SDK
        await OneSignal.login(externalId);
        await Supabase.instance.client
            .from("HospitalAuth")
            .update({"onesignal_id": externalId}).eq("uId", response.user!.id);
        emit(state.copyWith(loginState: RequestState.success));
        hospitalLoginSuccess(context);
      } else if (response.user!.identities!.first.identityData!['roule'] ==
          'user') {
        Supabase.instance.client.auth.signOut();
        emit(state.copyWith(
            loginState: RequestState.error,
            errorMessage: "Authorization Error"));
        hospitalLoginErorr(context, "Your account is not a hospital");
      } else {
        emit(state.copyWith(
            loginState: RequestState.error,
            errorMessage: "Authorization Error"));
        hospitalLoginErorr(context, "Authorization Error");
      }
      ;
    } on AuthException catch (error) {
      hospitalLoginErorr(context, "Authorization Error");
      emit(state.copyWith(
          loginState: RequestState.error, errorMessage: error.code));
    }
  }
}
