import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/hospital_layout/hospital_exchenged/model/hospital_exchanged_model.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'hospital_exchenged_state.dart';

class HospitalExchengedCubit extends Cubit<HospitalExchengedState> {
  HospitalExchengedCubit() : super(HospitalExchengedState());

  void getExchenged() async {
    emit(state.copyWith(getExchengedState: RequestState.loading));
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from("payments")
          .select('*,HospitalAuth(*),UserAuth(*)')
          .eq("hospital_uId", supabase.auth.currentUser!.id);
      emit(state.copyWith(
        hospitalExchangedModel:
            response.map((e) => HospitalExchangedModel.fromJson(e)).toList(),
        getExchengedState: RequestState.success,
      ));
    } on PostgrestException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } on SocketException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void changeStatus(int index) async {
    emit(state.copyWith(updateExchengedState: RequestState.loading));
    try {
      final supabase = Supabase.instance.client;
      await supabase
          .from("payments")
          .update({"status": "complete"}).match({"id": index});
      emit(state.copyWith(updateExchengedState: RequestState.success));
      getExchenged();
    } on PostgrestException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } on SocketException catch (e) {
      emit(state.copyWith(errorMessage: e.message));
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
