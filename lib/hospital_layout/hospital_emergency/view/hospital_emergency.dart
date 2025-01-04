import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:blood_donation/hospital_layout/hospital_emergency/view_model/cubit/hospital_emergency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HospitalEmergency extends StatelessWidget {
  const HospitalEmergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HospitalEmergencyCubit, HospitalEmergencyState>(
      bloc: getIt<HospitalEmergencyCubit>()..getUsersData(),
      builder: (context, state) {
        switch (state.usersState) {
          case RequestState.init:
          case RequestState.loading:
            return Center(child: CircularProgressIndicator());
          case RequestState.success:
            return Scaffold(
              appBar: AppBar(
                title: Text("Emergency Alart Now".tr(context)),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('When do you need the blood donation?'.tr(context)),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: state.timeNeeded,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                            value: 'Urgent', child: Text('Urgent'.tr(context))),
                        DropdownMenuItem(
                            value: 'Today', child: Text('Today'.tr(context))),
                        DropdownMenuItem(
                            value: 'Tomorrow',
                            child: Text('Tomorrow'.tr(context))),
                      ],
                      onChanged: (value) {
                        getIt<HospitalEmergencyCubit>()
                            .toggleTimeNeeded(value!);
                      },
                      hint: Text('Select Time'.tr(context)),
                    ),
                    SizedBox(height: 16),

                    // Blood group
                    Text('What blood groups do you need?'.tr(context)),
                    SizedBox(height: 8),
                    GlobalTextFormFiled(
                      textEditingController: getIt<HospitalEmergencyCubit>()
                          .bloodSelectedController,
                      readOnly: true,
                      onTap: () {
                        selectedBloodGroupModelBottomSheet(context);
                      },
                    ),
                    SizedBox(height: 16),

                    Text('How many units are needed?'.tr(context)),
                    SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      value: state.unitsRequired,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      items: List.generate(
                        50,
                        (index) => DropdownMenuItem(
                          value: index + 1,
                          child: Text('${index + 1} ${"unit".tr(context)}'),
                        ),
                      ),
                      onChanged: (value) {
                        getIt<HospitalEmergencyCubit>()
                            .toggleUnitsRequired(value!);
                      },
                      hint: Text('Select Units Required'.tr(context)),
                    ),
                    SizedBox(height: 16),

                    SizedBox(height: 32),

                    // Request Button
                  ],
                )),
              ),
              bottomNavigationBar: state.searchUserState == RequestState.loading
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )),
                      ],
                    )
                  : Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!state.bloodSelected.entries
                              .any((element) => element.value == true)) {
                            globalSnackbar(context,
                                "Please Select Blood Group".tr(context),
                                backgroundColor: Colors.red);
                          } else if (state.timeNeeded == null ||
                              state.unitsRequired == null) {
                            globalSnackbar(
                                context,
                                backgroundColor: Colors.red,
                                state.timeNeeded == null
                                    ? "Please Select Time Needed".tr(context)
                                    : "Please Select Units Required"
                                        .tr(context));
                          } else {
                            getIt<HospitalEmergencyCubit>().filterUsers();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor:
                              Theme.of(context).colorScheme.surface,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Request Blood'.tr(context),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
            );
          case RequestState.error:
            return Center(child: Text("Something went wrong".tr(context)));
          default:
            return Container();
        }
      },
      listener: (BuildContext context, HospitalEmergencyState state) {
        if (state.searchUserState == RequestState.success) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Send Request Emergency".tr(context)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "${"Count Users".tr(context)} : ${state.searchUserResult!.length}"),
                  Row(
                    children: [
                      if (!(state.sendEmergencyRequestNotificationState ==
                          RequestState.loading))
                        TextButton.icon(
                          onPressed: () {
                            getIt<HospitalEmergencyCubit>()
                                .sendEmergencyRequest(
                                    context,
                                    state.searchUserResult!.map((toElement) {
                                      return toElement.oneSignalId!;
                                    }).toList());
                          },
                          label: Text("Send".tr(context)),
                          icon: Icon(Icons.send),
                        ),
                      if ((state.sendEmergencyRequestNotificationState ==
                          RequestState.loading))
                        CircularProgressIndicator(),
                      Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: Text("cancel".tr(context)),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        if (state.sendEmergencyRequestNotificationState ==
            RequestState.success) {
          Navigator.pop(context);
          globalSnackbar(context, "Request Sent Successfully".tr(context),
              backgroundColor: Colors.green);
        }
      },
    );
  }

  Future<dynamic> selectedBloodGroupModelBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        child: BlocBuilder<HospitalEmergencyCubit, HospitalEmergencyState>(
          bloc: getIt<HospitalEmergencyCubit>(),
          builder: (context, state) {
            return SizedBox(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Blood Group".tr(context)),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: state.bloodSelected.entries.map((entry) {
                            final disease = entry.key;
                            final isSelected = entry.value;
                            return CheckboxListTile(
                              title: Text(disease.tr(context)),
                              value: isSelected,
                              onChanged: (_) {
                                getIt<HospitalEmergencyCubit>()
                                    .toggleDiseaseSelection(disease);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("confirm".tr(context))),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
