import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'hospital_profile_state.dart';

class HospitalProfileCubit extends Cubit<HospitalProfileState> {
  HospitalProfileCubit() : super(HospitalProfileState());
  final subabase = Supabase.instance.client;
  getInfo() async {
    try {
      final resonse = await subabase
          .from("HospitalAuth")
          .select()
          .eq("uId", subabase.auth.currentUser!.id);
      emit(state.copyWith(
          hospitalProfileState: RequestState.success,
          hospitalProfileModel: HospitalProfileModel.fromMap(resonse.first)));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
          hospitalProfileState: RequestState.error, errorMessage: e.message));
    } on SocketException catch (e) {
      emit(state.copyWith(
          hospitalProfileState: RequestState.error,
          errorMessage: e.osError!.message));
    } catch (e) {
      emit(state.copyWith(
          hospitalProfileState: RequestState.error,
          errorMessage: e.toString()));
    }
  }
}
