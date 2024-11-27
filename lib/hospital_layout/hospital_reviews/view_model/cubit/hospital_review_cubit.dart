import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/hospital_review_model.dart';

part 'hospital_review_state.dart';

class HospitalReviewCubit extends Cubit<HospitalReviewState> {
  HospitalReviewCubit() : super(HospitalReviewState()) {
    getReviews();
  }
  getReviews() async {
    try {
      final response = await Supabase.instance.client
          .from('Reviews_hospital')
          .select(
              'id, review,created_at,reating,HospitalAuth(name),UserAuth(user_full_name,user_blood_type)')
          .eq('hospital_id', Supabase.instance.client.auth.currentUser!.id);

      emit(state.copyWith(
          reviewsState: RequestState.success,
          hospitalReviewModel:
              response.map((e) => HospitalReviewModel.fromMap(e)).toList()));

      calculateRatingsDistribution(state.hospitalReviewModel);
    } on SocketException catch (e) {
      emit(state.copyWith(
          reviewsState: RequestState.error, errorMessage: e.toString()));
    }
  }

  Map<int, int> calculateRatingsDistribution(
      List<HospitalReviewModel>? hospitalReviewModel) {
    Map<int, int> distribution = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
    };

    // تمرير جميع التقييمات وتحديث التوزيع
    for (HospitalReviewModel rating in hospitalReviewModel!) {
      if (distribution.containsKey(rating.rating!.toInt())) {
        distribution[rating.rating!.toInt()] =
            distribution[rating.rating!.toInt()]! + 1;
      }
    }

    return distribution;
  }
}
