import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../../core/enum/request_state.dart';
import '../../../../core/methods/send_notification.dart';
import '../../../../hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import '../../../user_profile/view_model/user_profile_cubit.dart';

part 'user_send_appointment_state.dart';

class UserSendAppointmentCubit extends Cubit<UserSendAppointmentState> {
  UserSendAppointmentCubit() : super(UserSendAppointmentState());
  sendRequestAppointment(
      HospitalProfileModel model, String content, String title, context) async {
    emit(state.copyWith(sendRequestAppointmentState: RequestState.loading));

    await getIt<UserProfileCubit>().getUserProfile();

    final uid = getIt<UserProfileCubit>().state.userSignupModel!.uId;
    await Supabase.instance.client
        .from("hospital_appointment")
        .select("user_id")
        .eq("user_id", uid!)
        .eq("status", "pending")
        .then((onValue) async {
      if (onValue.isEmpty) {
        int monthsDifference = calculateMonthsDifference(DateTime.parse(
            getIt<UserProfileCubit>()
                .state
                .userSignupModel!
                .dateLastBloodDonation!));
        if (monthsDifference < 2) {
          emit(state.copyWith(
              sendRequestAppointmentState: RequestState.error,
              errorMessage:
                  "It must have been 2 months since your last donation."));
        } else {
          await Supabase.instance.client
              .from("hospital_appointment")
              .select("user_id")
              .eq("user_id", uid!)
              .eq("status", "accepted")
              .then((onValue) async {
            if (onValue.isEmpty) {
              await Supabase.instance.client
                  .from("hospital_appointment")
                  .insert({
                "hospital_id": model.uId,
                "user_id": uid,
                "content": content,
                "title": title,
                "status": "pending",
                "time": state.selectedTimeBloodDonationAppointment,
                "day": state.selectedDayBloodDonationAppointment,
              }).then((onValue) {
                sendNotification(
                  contentAr:
                      "لقد تم حجز موعد التبرع بالدم يوم ${state.selectedDayBloodDonationAppointment!.trAr(context)} في تمام الساعة ${state.selectedTimeBloodDonationAppointment!.replaceAll("AM", "صباحا").replaceAll("PM", "ٌمساءاً")}",
                  contents: content,
                  headings: title,
                  headingAr: "موعد التبرع بالدم",
                  recivedIds: ["${model.oneSignalId}"],
                );
                emit(state.copyWith(
                    sendRequestAppointmentState: RequestState.success));
              }).catchError((onError) {
                emit(state.copyWith(
                    sendRequestAppointmentState: RequestState.error));
              });
            } else {
              emit(state.copyWith(
                  sendRequestAppointmentState: RequestState.error,
                  errorMessage: "You have a Accepted request"));
            }
          }).catchError((onError) {
            emit(state.copyWith(
                sendRequestAppointmentState: RequestState.error));
          });
        }
      } else {
        emit(state.copyWith(
            sendRequestAppointmentState: RequestState.error,
            errorMessage: "You have a pending request"));
      }
    });
  }

  toggleSelectedDayBloodDonationAppointment(String day) =>
      emit(state.copyWith(selectedDayBloodDonationAppointment: day));
  toggleSelectedTimeBloodDonationAppoinment(String time) =>
      emit(state.copyWith(selectedTimeBloodDonationAppointment: time));

  int calculateMonthsDifference(DateTime startDate) {
    DateTime today = DateTime.now();
    int yearsDiff = today.year - startDate.year;
    int monthsDiff = today.month - startDate.month;

    // حساب العدد الكلي للأشهر
    int totalMonths = (yearsDiff * 12) + monthsDiff;

    if (today.day < startDate.day) {
      totalMonths--;
    }

    return totalMonths;
  }
}
