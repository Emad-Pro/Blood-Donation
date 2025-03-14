import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/methods/send_notification.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../user_layout/user_auth/user_signup/model/user_signup_model.dart';
import '../../../received_history_donations/model/hospital_donor_recevied_requests_model.dart';

part 'hospital_give_reward_for_request_donation_state.dart';

class HospitalGiveRewardForRequestDonationCubit
    extends Cubit<HospitalGiveRewardForRequestDonationState> {
  HospitalGiveRewardForRequestDonationCubit()
      : super(HospitalGiveRewardForRequestDonationState());
  TextEditingController bagsController = TextEditingController();
  getAcceptedRequestState() async {
    emit(state.copyWith(getAcceptedRequestsState: RequestState.loading));
    try {
      final supabase = Supabase.instance.client;
      final userId = await supabase.auth.currentSession!.user.id;
      final response = await supabase
          .from("hospital_appointment")
          .select("UserAuth(*),HospitalAuth(*),*")
          .eq("hospital_id", userId)
          .eq("status", "accepted")
          .order("created_at", ascending: false);
      emit(state.copyWith(
          getAcceptedRequestsModel: response
              .map((e) => HospitalDonorReceviedRequestsModel.fromMap(e))
              .toList(),
          getAcceptedRequestsState: RequestState.success));
    } on SocketException catch (e) {
      emit(state.copyWith(
        getAcceptedRequestsState: RequestState.error,
        getAcceptedRequestsMessage: e.message,
      ));
    } on AuthException catch (e) {
      emit(state.copyWith(
        getAcceptedRequestsState: RequestState.error,
        getAcceptedRequestsMessage: e.message,
      ));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
        getAcceptedRequestsState: RequestState.error,
        getAcceptedRequestsMessage: e.message,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        getAcceptedRequestsState: RequestState.error,
        getAcceptedRequestsMessage: e.toString(),
      ));
    }
  }

  confirmDonation(
      {required int id,
      required BuildContext context,
      required UserSignupModel userprofileModel}) async {
    emit(state.copyWith(confirmRequestState: RequestState.loading));
    try {
      await Supabase.instance.client.from("hospital_appointment").update({
        "status": "completed",
        "unit": int.parse(bagsController.text)
      }).eq("id", id);
      await Supabase.instance.client
          .from("UserAuth")
          .update({"user_last_dontaion": DateTime.now().toIso8601String()}).eq(
              "user_email", userprofileModel.email!);
      await Supabase.instance.client
          .rpc('increment_points', params: {
            'uid': userprofileModel.uId,
            'value': int.parse(bagsController.text) * 100
          })
          .then((onValue) {})
          .catchError((onError) {
            print(onError);
          });
      globalSnackbar(context, "Request Completed Successfully".tr(context),
          backgroundColor: Colors.green);
      sendNotification(
        contents: "Request Completed Successfully",
        headings: "Blood Donation",
        recivedIds: [userprofileModel.oneSignalId],
        contentAr: "تم اكمال الطلب بنجاح",
        headingAr: "التبرع بالدم",
      );
      Navigator.pop(context);
      emit(state.copyWith(confirmRequestState: RequestState.success));
      await getAcceptedRequestState();
    } on SocketException catch (_) {
      emit(state.copyWith(
        confirmRequestState: RequestState.error,
      ));
    } on PostgrestException catch (_) {
      emit(state.copyWith(
        confirmRequestState: RequestState.error,
      ));
    } on Exception catch (_) {
      emit(state.copyWith());
    }
  }
}
