import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/methods/send_notification.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../user_layout/user_auth/user_signup/model/user_signup_model.dart';

part 'hospital_give_rewards_emergency_state.dart';

class HospitalGiveRewardsEmergencyCubit
    extends Cubit<HospitalGiveRewardsEmergencyState> {
  HospitalGiveRewardsEmergencyCubit()
      : super(HospitalGiveRewardsEmergencyState());

  TextEditingController emailController = TextEditingController();
  TextEditingController bloodBagsCountController = TextEditingController();

  void confirm() async {
    emit(state.copyWith(userGivePoint: RequestState.loading));
    final hospitalId =
        await Supabase.instance.client.auth.currentSession!.user.id;
    await Supabase.instance.client
        .from("UserAuth")
        .update({"user_last_dontaion": DateTime.now().toIso8601String()}).eq(
            "user_email", emailController.text);
    await Supabase.instance.client.rpc('increment_point', params: {
      'uid': state.userModel!.uId!,
      'value': int.parse(bloodBagsCountController.text) * 100
    });
    await Supabase.instance.client.from("emergency_donation").insert({
      "user_uid": state.userModel!.uId,
      "point": int.parse(bloodBagsCountController.text) * 100,
      "hospital_uid": hospitalId,
      "blood_bags_count": int.parse(bloodBagsCountController.text)
    }).then((onValue) {
      emit(state.copyWith(userGivePoint: RequestState.success));
      sendNotification(
          contents:
              "Congratulations ! You have successfully added emergency blood donation points",
          contentAr: "تهانينا! تم اضافة نقاط التبرع الطارئ بنجاح",
          headings: "Emergency blood donation points",
          headingAr: "نقاط التبرع الطارئ",
          recivedIds: [state.userModel!.oneSignalId]);
      emailController.clear();
      bloodBagsCountController.clear();
    }).catchError((onError) {
      print(onError);
      emit(state.copyWith(userGivePoint: RequestState.error));
    });
  }

  checkEmail(BuildContext context) async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("please_enter_donor_email".tr(context)),
      ));
      emit(state.copyWith(findUserState: RequestState.error));
    } else if (bloodBagsCountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("please_enter_blood_bags_count".tr(context)),
      ));
      emit(state.copyWith(findUserState: RequestState.error));
    } else {
      if (isValidEmail(emailController.text)) {
        final response = await Supabase.instance.client
            .from("UserAuth")
            .select("*")
            .eq("user_email", emailController.text);
        if (response.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("this_donor_does_not_exist".tr(context)),
          ));
          emit(state.copyWith(findUserState: RequestState.error));
        } else {
          emit(state.copyWith(
              userModel: UserSignupModel.fromJson(response[0]),
              findUserState: RequestState.success));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("please_enter_valid_donor_email".tr(context)),
        ));
        emit(state.copyWith(findUserState: RequestState.error));
      }
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
