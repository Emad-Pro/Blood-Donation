import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/enum/request_state.dart';
import '../../model/hospital_medicine_rewards_model.dart';

part 'hospital_medicine_rewards_state.dart';

class HospitalMedicineRewardsCubit extends Cubit<HospitalMedicineRewardsState> {
  HospitalMedicineRewardsCubit() : super(HospitalMedicineRewardsState());

  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> fetchMedicines() async {
    emit(state.copyWith(getMedicineRewardsState: RequestState.loading));
    print(supabase.auth.currentUser!.id);
    try {
      final response = await supabase
          .from('medicines')
          .select()
          .eq('uId', supabase.auth.currentUser!.id);
      emit(state.copyWith(
          getMedicineRewardsState: RequestState.success,
          getMedicineRewardsModel: response
              .map((e) => HospitalMedicineRewardsModel.fromJson(e))
              .toList()));
    } catch (e) {
      emit(state.copyWith(getMedicineRewardsState: RequestState.error));
    }
  }

  Future<void> addMedicine(
      String name, int quantity, String description, int points) async {
    try {
      await supabase.from('medicines').insert({
        'name': name,
        'quantity': quantity,
        'description': description,
        'points': points,
        'uId': supabase.auth.currentUser!.id
      });
      fetchMedicines();
      emit(state.copyWith(addMedicineRewardsState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(
          addMedicineRewardsState: RequestState.error,
          addMedicineRewardsErrorMessage: e.toString()));
    }
  }

  Future<void> updateMedicine(
      int id, String name, int quantity, String description, int points) async {
    try {
      emit(state.copyWith(updateMedicineRewardsState: RequestState.loading));
      await supabase.from('medicines').update({
        'name': name,
        'quantity': quantity,
        'description': description,
        'points': points,
      }).match({'id': id});
      emit(state.copyWith(updateMedicineRewardsState: RequestState.success));
      fetchMedicines();
    } catch (e) {
      emit(state.copyWith(
          updateMedicineRewardsState: RequestState.error,
          updateMedicineRewardsErrorMessage: e.toString()));
    }
  }

  Future<void> deleteMedicine(int id) async {
    try {
      emit(state.copyWith(deleteMedicineRewardsState: RequestState.loading));
      await supabase.from('medicines').delete().eq("id", id);
      fetchMedicines();
      emit(state.copyWith(deleteMedicineRewardsState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(
          deleteMedicineRewardsState: RequestState.error,
          deleteMedicineRewardsErrorMessage: e.toString()));
    }
  }
}
