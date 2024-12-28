import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/enum/request_state.dart';
import '../../../../hospital_layout/hospital_reviews/model/hospital_review_model.dart';

part 'user_view_review_hospital_state.dart';

class UserViewReviewHospitalCubit extends Cubit<UserViewReviewHospitalState> {
  UserViewReviewHospitalCubit() : super(UserViewReviewHospitalState());
  TextEditingController reviewController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  void getReviewsWithUid(String uId) async {
    try {
      final response = await Supabase.instance.client
          .from('Reviews_hospital')
          .select(
              'id, review,created_at,reating,HospitalAuth(name),UserAuth(user_full_name,user_blood_type)')
          .eq('hospital_id', uId);
      emit(state.copyWith(
          reviewsState: RequestState.success,
          hospitalReviewModel:
              response.map((e) => HospitalReviewModel.fromMap(e)).toList()));
    } on SocketException catch (e) {
      emit(state.copyWith(
          reviewsState: RequestState.error, errorMessage: e.toString()));
    }
  }

  addReview(String hospitalId) async {
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      await Supabase.instance.client.from('Reviews_hospital').insert({
        'review': reviewController.text,
        'reating': state.currentRating,
        'hospital_id': hospitalId,
        "user_id": userId
      });
      getReviewsWithUid(hospitalId);
      emit(state.copyWith(
          addReviewState: RequestState.success, currentRating: 0));
      reviewController.clear();
    } on SocketException catch (e) {
      emit(state.copyWith(
          addReviewState: RequestState.error, errorMessage: e.toString()));
    }
  }

  changeReatingValue(double value) {
    emit(state.copyWith(currentRating: value));
  }
}
