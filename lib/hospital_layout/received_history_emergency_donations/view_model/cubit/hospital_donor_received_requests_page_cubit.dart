import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/methods/send_notification.dart';
import 'package:blood_donation/hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../user_layout/user_auth/user_signup/model/user_signup_model.dart';
import '../../model/emergency_model/hospital_emergency_model.dart';
import '../../model/hospital_donor_recevied_requests_model.dart';

part 'hospital_donor_received_requests_page_state.dart';

class HospitalDonorReceivedRequestsCubit
    extends Cubit<HospitalDonorReceivedRequestsState> {
  HospitalDonorReceivedRequestsCubit()
      : super(HospitalDonorReceivedRequestsState());
  TextEditingController reasonController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  getEmergencyData() async {
    final hospitalId = await Supabase.instance.client.auth.currentUser!.id;
    emit(state.copyWith(historyEmergencyDonorState: RequestState.loading));
    final supabase = Supabase.instance.client;
    try {
      final result = await supabase
          .from("emergency_donation")
          .select("UserAuth(*),HospitalAuth(*),*")
          .eq("hospital_uid", hospitalId)
          .order("created_at", ascending: false);

      emit(state.copyWith(
          historyEmergencyDonorState: RequestState.success,
          historyEmergencyDonorModel:
              result.map((e) => HospitalEmergencyModel.fromMap(e)).toList()));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
        historyEmergencyDonorState: RequestState.error,
      ));
    }
  }

  getData() async {
    emit(state.copyWith(hospitaldonorReceivedState: RequestState.loading));
    final supabase = Supabase.instance.client;

    try {
      final result = await supabase
          .from("hospital_appointment")
          .select("UserAuth(*),HospitalAuth(*),*")
          .eq("hospital_id", supabase.auth.currentUser!.id)
          .eq("status", "pending")
          .order("created_at", ascending: false);
      emit(state.copyWith(
          hospitaldonorReceivedState: RequestState.success,
          hospitalDonorReceviedRequestsModel: result
              .map((e) => HospitalDonorReceviedRequestsModel.fromMap(e))
              .toList()));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
          hospitaldonorReceivedState: RequestState.error,
          errorMessage: e.message));
    } on SocketException catch (e) {
      emit(state.copyWith(
          hospitaldonorReceivedState: RequestState.error,
          errorMessage: e.message));
    } on AuthApiException catch (e) {
      emit(state.copyWith(
          hospitaldonorReceivedState: RequestState.error,
          errorMessage: e.message));
    } on AuthException catch (e) {
      emit(state.copyWith(
          hospitaldonorReceivedState: RequestState.error,
          errorMessage: e.message));
    }
  }

  proccessOrder(int id, String proccess,
      {String? reason,
      UserSignupModel? userprofileModel,
      HospitalProfileModel? hospitalModel}) async {
    emit(state.copyWith(updateAppointmentState: RequestState.loading));
    final supabase = Supabase.instance.client;
    try {
      if (reason == null) {
        await supabase.from("hospital_appointment").update({
          "status": proccess,
          "content": "Your request in ${hospitalModel!.name} has been Accepted",
          "title": "Request Accepted"
        }).eq("id", id);
        sendNotification(
            contents: "Your request in ${hospitalModel.name} has been Accepted",
            headings: "Request Accepted",
            contentAr: "تم قبول طلبك في ${hospitalModel.name}",
            headingAr: "تم قبول الطلب",
            recivedIds: [userprofileModel!.oneSignalId!]);
        emit(state.copyWith(updateAppointmentState: RequestState.success));
      } else {
        final content =
            "Your request in ${hospitalModel!.name} has been Rejected ${reason}";
        await supabase.from("hospital_appointment").update({
          "status": proccess,
          "reason": reason,
          "content": content,
          "title": "Request Rejected"
        }).eq("id", id);
        sendNotification(
            contents: content,
            headings: "Request Rejected",
            contentAr: "تم رفض طلبك في ${hospitalModel.name} ${reason}",
            headingAr: " رفض الطلب",
            recivedIds: [userprofileModel!.oneSignalId!]);
        emit(state.copyWith(updateAppointmentState: RequestState.success));
      }

      getData();
    } on PostgrestException catch (e) {
      print(e);
      emit(state.copyWith(updateAppointmentState: RequestState.error));
    } on SocketException catch (e) {
      print(e);
    }
  }

  getHistoryData() async {
    emit(state.copyWith(hospitaldonorReceivedState: RequestState.loading));
    final supabase = Supabase.instance.client;

    try {
      final result = await supabase
          .from("hospital_appointment")
          .select("UserAuth(*),HospitalAuth(*),*")
          .eq("hospital_id", supabase.auth.currentUser!.id)
          .neq("status", "pending")
          .order("created_at", ascending: false);
      emit(state.copyWith(
          historyAppointmentState: RequestState.success,
          historyDonorReceviedRequestsModel: result
              .map((e) => HospitalDonorReceviedRequestsModel.fromMap(e))
              .toList()));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
          historyAppointmentState: RequestState.error,
          errorMessage: e.message));
    } on SocketException catch (e) {
      emit(state.copyWith(
          historyAppointmentState: RequestState.error,
          errorMessage: e.message));
    } on AuthApiException catch (e) {
      emit(state.copyWith(
          historyAppointmentState: RequestState.error,
          errorMessage: e.message));
    } on AuthException catch (e) {
      emit(state.copyWith(
          historyAppointmentState: RequestState.error,
          errorMessage: e.message));
    }
  }
}
