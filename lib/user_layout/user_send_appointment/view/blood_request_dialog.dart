import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:blood_donation/user_layout/user_send_appointment/view_model/cubit/user_send_appointment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/enum/request_state.dart';
import '../../../hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';

void showScheduleDialog(BuildContext context,
    {required HospitalProfileModel hospitalProfileModel}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => UserSendAppointmentCubit(),
        child: AlertDialog(
          title: Text("Select Donation Time".tr(context)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocConsumer<UserSendAppointmentCubit, UserSendAppointmentState>(
                listener: (context, state) {
                  if (state.sendRequestAppointmentState ==
                      RequestState.success) {
                    Navigator.pop(context);
                    globalSnackbar(
                        context, "Request Sent Successfully".tr(context),
                        backgroundColor: Colors.green);
                  }
                  if (state.sendRequestAppointmentState == RequestState.error) {
                    Navigator.pop(context);
                    globalSnackbar(
                        context,
                        state.errorMessage!.tr(context) != ""
                            ? state.errorMessage!.tr(context)
                            : state.errorMessage!,
                        backgroundColor: Colors.red);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: state.selectedDayBloodDonationAppointment,
                        hint: Text("Select a Day".tr(context)),
                        items: hospitalProfileModel.dayes!
                            .replaceAll("[", "")
                            .replaceAll("]", "")
                            .replaceAll(" ", "")
                            .split(",")
                            .map((String day) {
                          return DropdownMenuItem<String>(
                            value: day.replaceAll(" ", ""),
                            child: Text(day.replaceAll(" ", "").tr(context)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          context
                              .read<UserSendAppointmentCubit>()
                              .toggleSelectedDayBloodDonationAppointment(
                                  value!.replaceAll(" ", ""));
                          print(value);
                        },
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 16),
              BlocBuilder<UserSendAppointmentCubit, UserSendAppointmentState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: generateWorkHours(
                              startHour: int.parse(hospitalProfileModel
                                  .openingTime!
                                  .split(":")
                                  .first),
                              endHour: int.parse(hospitalProfileModel
                                  .closingTime!
                                  .split(":")
                                  .first))
                          .map((toElement) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              context
                                  .read<UserSendAppointmentCubit>()
                                  .toggleSelectedTimeBloodDonationAppoinment(
                                      toElement);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: (state.selectedTimeBloodDonationAppointment !=
                                                null &&
                                            state.selectedTimeBloodDonationAppointment ==
                                                toElement)
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "${toElement.replaceAll("AM", "am".tr(context)).replaceAll("PM", "pm".tr(context))}",
                                style: TextStyle(
                                  color: (state.selectedTimeBloodDonationAppointment !=
                                              null &&
                                          state.selectedTimeBloodDonationAppointment ==
                                              toElement)
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel".tr(context)),
            ),
            BlocBuilder<UserSendAppointmentCubit, UserSendAppointmentState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (state.selectedDayBloodDonationAppointment == null ||
                        state.selectedTimeBloodDonationAppointment == null) {
                      if (state.selectedDayBloodDonationAppointment == null) {
                        globalSnackbar(
                            context, "Please Select Day".tr(context));
                      } else {
                        globalSnackbar(
                            context, "Please Select Time".tr(context));
                      }
                    } else {
                      final contentEn =
                          "You have a blood donation appointment at ${state.selectedDayBloodDonationAppointment!.trEn(context)} at ${state.selectedTimeBloodDonationAppointment} ";
                      final title = "Blood Donation Appointment";
                      context
                          .read<UserSendAppointmentCubit>()
                          .sendRequestAppointment(
                              hospitalProfileModel, contentEn, title, context);
                    }
                  },
                  child:
                      state.sendRequestAppointmentState == RequestState.loading
                          ? CircularProgressIndicator()
                          : Text("Confirm".tr(context)),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

List<String> generateWorkHours({required int startHour, required int endHour}) {
  List<String> hours = [];
  int currentHour = startHour;

  do {
    String timeLabel = formatTime(currentHour);
    hours.add("$timeLabel");
    currentHour = (currentHour + 1) % 24;
  } while (currentHour != endHour);

  return hours;
}

String formatTime(int hour) {
  String period = hour < 12 ? "AM" : "PM";
  int formattedHour = hour % 12 == 0 ? 12 : hour % 12;
  return "$formattedHour $period";
}
