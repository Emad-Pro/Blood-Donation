import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/hospital_donor_recevied_requests_model.dart';

part 'hospital_donor_received_requests_page_state.dart';

class HospitalDonorReceivedRequestsCubit
    extends Cubit<HospitalDonorReceivedRequestsState> {
  HospitalDonorReceivedRequestsCubit()
      : super(HospitalDonorReceivedRequestsState());

  getData() async {
    emit(state.copyWith(hospitaldonorReceivedState: RequestState.loading));
    final supabase = Supabase.instance.client;

    try {
      final result = await supabase
          .from("hospital_appointment")
          .select("UserAuth(*),HospitalAuth(*),*")
          .eq("hospital_id", supabase.auth.currentUser!.id);
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
}
