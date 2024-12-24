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

    await Supabase.instance.client.from("hospital_appointment").insert({
      "hospital_id": model.uId,
      "user_id": getIt<UserProfileCubit>().state.userSignupModel!.uId,
      "content": content,
      "title": title,
      "status": "pending",
    }).then((onValue) {
      sendNotification(
        contentAr:
            "لقد تم حجز موعد التبرع بالدم يوم ${state.selectedDayBloodDonationAppointment!.trAr(context)} في تمام الساعة ${state.selectedTimeBloodDonationAppointment!.replaceAll("AM", "صباحا").replaceAll(
                  "PM",
                  "ٌمساءاً",
                )}",
        contents: content,
        headings: title,
        headingAr: "موعد التبرع بالدم",
        recivedIds: ["${model.oneSignalId}"],
      );
      emit(state.copyWith(sendRequestAppointmentState: RequestState.success));
    }).catchError((onError) {
      emit(state.copyWith(sendRequestAppointmentState: RequestState.error));
    });
  }

  toggleSelectedDayBloodDonationAppointment(String day) =>
      emit(state.copyWith(selectedDayBloodDonationAppointment: day));
  toggleSelectedTimeBloodDonationAppoinment(String time) =>
      emit(state.copyWith(selectedTimeBloodDonationAppointment: time));
}
