import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/methods/send_notification.dart';
import 'package:blood_donation/user_layout/my_appointment/model/my_appointment_model.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../user_profile/view_model/user_profile_cubit.dart';

part 'my_appointment_state.dart';

class MyAppointmentCubit extends Cubit<MyAppointmentState> {
  MyAppointmentCubit() : super(MyAppointmentState());

  Future<void> getMyAppointments() async {
    emit(state.copyWith(appointmentsState: RequestState.loading));
    try {
      await getIt<UserProfileCubit>().getUserProfile();

      final uid = getIt<UserProfileCubit>().state.userSignupModel!.uId;
      final response = await Supabase.instance.client
          .from("hospital_appointment")
          .select("HospitalAuth(name,onesignal_id),*")
          .eq("user_id", uid!)
          .order("created_at", ascending: false);
      emit(
        state.copyWith(
          appointments:
              response.map((e) => MyAppointmentModel.fromJson(e)).toList(),
          appointmentsState: RequestState.success,
        ),
      );
    } on SocketException catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        appointmentsState: RequestState.error,
      ));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        appointmentsState: RequestState.error,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        appointmentsState: RequestState.error,
      ));
    }
  }

  Future<void> deleteMyAppointment(String id) async {
    emit(state.copyWith(appointmentsDeleteState: RequestState.loading));
    try {
      await Supabase.instance.client
          .from("hospital_appointment")
          .delete()
          .eq("id", id);
      emit(state.copyWith(appointmentsDeleteState: RequestState.success));
      await getMyAppointments();
    } on SocketException catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        appointmentsDeleteState: RequestState.error,
      ));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        appointmentsDeleteState: RequestState.error,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        appointmentsDeleteState: RequestState.error,
      ));
    }
  }

  Future<void> updateMyAppointment(String id, String? oneSignalId) async {
    emit(state.copyWith(appointmentsUpdateState: RequestState.loading));
    try {
      await Supabase.instance.client
          .from("hospital_appointment")
          .update({"status": "canceled"}).eq("id", id);
      sendNotification(
          contents: "Appointment has been Canceled",
          headings: "Blood Donation",
          contentAr: "تم إلغاء الموعد",
          headingAr: "التبرع بالدم",
          recivedIds: [oneSignalId]);
      emit(state.copyWith(appointmentsUpdateState: RequestState.success));
      await getMyAppointments();
    } on SocketException catch (e) {
      emit(state.copyWith(
        appointmentsUpdateState: RequestState.error,
      ));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
        appointmentsUpdateState: RequestState.error,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        appointmentsUpdateState: RequestState.error,
      ));
    }
  }
}
