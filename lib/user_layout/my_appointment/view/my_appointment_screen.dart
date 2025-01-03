import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:blood_donation/user_layout/my_appointment/view_model/cubit/my_appointment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/request_state.dart';

class MyAppointmentScreen extends StatelessWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAppointmentCubit()..getMyAppointments(),
      child: Scaffold(
        appBar: AppBar(title: Text("My Appointments".tr(context))),
        body: BlocConsumer<MyAppointmentCubit, MyAppointmentState>(
          listener: (context, state) {
            if (state.appointmentsDeleteState == RequestState.success) {
              globalSnackbar(
                  context, "Appointment Deleted Successfully".tr(context),
                  backgroundColor: Colors.green);
            }
            if (state.appointmentsDeleteState == RequestState.error) {
              globalSnackbar(context, "Error Deleting Appointment".tr(context),
                  backgroundColor: Colors.red);
            }
            if (state.appointmentsUpdateState == RequestState.success) {
              globalSnackbar(
                  context, "Appointment Canceled Successfully".tr(context),
                  backgroundColor: Colors.green);
            }
            if (state.appointmentsUpdateState == RequestState.error) {
              globalSnackbar(context, "Error Canceled Appointment".tr(context),
                  backgroundColor: Colors.red);
            }
          },
          builder: (context, state) {
            switch (state.appointmentsState) {
              case RequestState.init:
              case RequestState.loading:
                return Center(child: CircularProgressIndicator());
              case RequestState.success:
                return state.appointments!.isEmpty
                    ? Center(child: Text("No Appointments".tr(context)))
                    : ListView.builder(
                        itemCount: state.appointments?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: CircleAvatar(
                                  child: Icon(Icons.local_hospital)),
                              title: Text(
                                  state.appointments![index].hospitalName!),
                              subtitle: Text(state.appointments![index].status!
                                  .tr(context)),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(state.appointments![index]
                                            .hospitalName!),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Date:".tr(context)),
                                                  Text(state
                                                      .appointments![index].day!
                                                      .tr(context)),
                                                ],
                                              ),
                                              Divider(),
                                              Row(children: [
                                                Text("Time:".tr(context)),
                                                Text(state.appointments![index]
                                                    .time!),
                                              ]),
                                              Divider(),
                                              Row(children: [
                                                Text("Status:".tr(context)),
                                                Text(state.appointments![index]
                                                    .status!
                                                    .tr(context)),
                                              ]),
                                              Divider(),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Close".tr(context)))
                                        ],
                                      );
                                    });
                              },
                              trailing: (state.appointments![index].status ==
                                      "pending")
                                  ? state.appointmentsDeleteState ==
                                          RequestState.loading
                                      ? CircularProgressIndicator()
                                      : IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            context
                                                .read<MyAppointmentCubit>()
                                                .deleteMyAppointment(state
                                                    .appointments![index].id!
                                                    .toString());
                                          },
                                        )
                                  : state.appointments![index].status ==
                                          "accepted"
                                      ? state.appointmentsUpdateState ==
                                              RequestState.loading
                                          ? CircularProgressIndicator()
                                          : IconButton(
                                              icon: Icon(Icons.close),
                                              onPressed: () {
                                                context
                                                    .read<MyAppointmentCubit>()
                                                    .updateMyAppointment(
                                                        state
                                                            .appointments![
                                                                index]
                                                            .id!
                                                            .toString(),
                                                        state
                                                            .appointments![
                                                                index]
                                                            .oneSignalId!);
                                              },
                                            )
                                      : null);
                        },
                      );
              case RequestState.error:
                return Center(child: Text(state.errorMessage));
            }
          },
        ),
      ),
    );
  }
}
