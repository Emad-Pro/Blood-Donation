import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/methods/send_notification.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../../hospital_layout/hospital_medicine_rewards/model/hospital_medicine_rewards_model.dart';
import '../../../user_home/view_model/cubit/user_home_cubit.dart';

part 'user_shop_rewards_state.dart';

class UserShopRewardsCubit extends Cubit<UserShopRewardsState> {
  UserShopRewardsCubit() : super(UserShopRewardsState());
  getMedcineRewards({required String hospitalId}) async {
    final supabase = Supabase.instance.client;
    try {
      final response =
          await supabase.from("medicines").select().eq("uId", hospitalId);
      emit(state.copyWith(
        medicineRewardsState: RequestState.success,
        medicineRewardsModel: response
            .map((e) => HospitalMedicineRewardsModel.fromJson(e))
            .toList(),
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        medicineRewardsState: RequestState.error,
        medicineRewardsErrorMessage: e.message,
      ));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
        medicineRewardsState: RequestState.error,
        medicineRewardsErrorMessage: e.message,
      ));
    }
  }

  buyItem(Map<String, dynamic> map,
      {required int currentPoints, required String hospitalOneSignalId}) async {
    emit(state.copyWith(paymentsState: RequestState.loading));
    final supabase = Supabase.instance.client;
    try {
      await supabase.from("payments").insert(map).then((onValue) async {
        final newPrice = currentPoints - map["point"];
        await supabase
            .from("donation_point")
            .update({"point": newPrice})
            .eq("uId", map["user_uId"])
            .then((onValue) {
              emit(state.copyWith(paymentsState: RequestState.success));
            });
        sendNotification(
            headingAr: "تبادل نقاط التبرع",
            contentAr: "قام متبرع بعملية تبادل نقاط التبرع",
            headings: "Exchange donation points",
            contents: "A donor exchanged donation points",
            recivedIds: [hospitalOneSignalId]);
      });
    } on SocketException catch (e) {
      emit(state.copyWith(paymentsState: RequestState.error));
    } on PostgrestException catch (e) {
      emit(state.copyWith(paymentsState: RequestState.error));
    }
  }
}
