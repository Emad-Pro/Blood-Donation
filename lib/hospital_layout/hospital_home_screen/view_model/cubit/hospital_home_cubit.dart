import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/hospital_layout/hospital_home_screen/model/hospital_donations_model.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/enum/request_state.dart';

part 'hospital_home_state.dart';

class HospitalHomeCubit extends Cubit<HospitalHomeState> {
  HospitalHomeCubit() : super(HospitalHomeState()) {
    getRecentDonations();
  }

  getHospitalReviews() async {
    try {
      final supabase = await Supabase.instance.client
          .from('Reviews_hospital')
          .select()
          .eq('hospital_id',
              Supabase.instance.client.auth.currentUser!.id.toString())
          .order('created_at', ascending: false)
          .limit(4);

      emit(state.copyWith(
          reviewsSliderState: RequestState.success,
          listReviewsSlider: supabase
              .map((toElement) => toElement['review'] as String)
              .toList()));
    } on SocketException catch (e) {
      emit(state.copyWith(
          reviewsSliderState: RequestState.error,
          errorReviewsSliderMessage: e.message));
    }
  }

  getRecentDonations() async {
    emit(state.copyWith(hospitalDonationsState: RequestState.loading));
    final supabase = Supabase.instance.client;

    try {
      final result = await supabase
          .from("hospital_appointment")
          .select("UserAuth(*),HospitalAuth(*),*")
          .eq("hospital_id", supabase.auth.currentUser!.id)
          .eq("status", "completed")
          .order("created_at", ascending: false);
      emit(state.copyWith(
          hospitalDonationsState: RequestState.success,
          hospitalDonationsModel:
              result.map((e) => HospitalDonationsModel.fromJson(e)).toList()));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
          hospitalDonationsState: RequestState.error,
          recentDontionsMessage: e.message));
    } on SocketException catch (e) {
      emit(state.copyWith(
          hospitalDonationsState: RequestState.error,
          recentDontionsMessage: e.message));
    } on AuthApiException catch (e) {
      emit(state.copyWith(
          hospitalDonationsState: RequestState.error,
          recentDontionsMessage: e.message));
    } on AuthException catch (e) {
      emit(state.copyWith(
          hospitalDonationsState: RequestState.error,
          recentDontionsMessage: e.message));
    }
  }
}
