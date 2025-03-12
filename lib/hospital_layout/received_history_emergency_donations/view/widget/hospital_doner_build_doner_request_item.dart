import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import '../../../../core/di/service_lacator.dart';
import '../../../../core/methods/calculate_distance.dart';
import '../../../../user_layout/user_auth/user_signup/model/user_signup_model.dart';
import '../../../hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';

import '../../view_model/cubit/hospital_donor_received_requests_page_cubit.dart';

class HospitalDonerBuildDonerRequestItem extends StatelessWidget {
  const HospitalDonerBuildDonerRequestItem(
      {super.key,
      required this.userprofileModel,
      required this.hospitalprofileModel,
      required this.orderId});
  final UserSignupModel? userprofileModel;
  final HospitalProfileModel? hospitalprofileModel;
  final int? orderId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Blood Group Widget

                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          //    color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.bloodtype,
                              color: Colors.red,
                              size: 30,
                            ),
                            SizedBox(height: 5),
                            Text(
                              userprofileModel!.selectedBloodType!,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Request Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${"${userprofileModel!.selectedGender!}".tr(context)}, ${DateTime.now().year - DateTime.parse(userprofileModel!.age!).year} ${"yr old".tr(context)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(userprofileModel!.fullName!),
                        SizedBox(height: 5),
                        Text(
                            "${calculateDistance(hospitalprofileModel!.latitude!, hospitalprofileModel!.longitude!, userprofileModel!.latitude!, userprofileModel!.longitude!).round()} ${"km".tr(context)}"),
                        SizedBox(height: 5),
                        Text(
                          userprofileModel!.currentLocation!,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  // Call Icon
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => DonorInfoShowDialog(
                                  userprofileModel: userprofileModel!));
                        },
                        icon: const Icon(
                          Icons.info,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      IconButton(
                        onPressed: () async {
                          await EasyLauncher.call(
                              number: userprofileModel!.phone!);
                        },
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Time Limit and Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Reject Donor".tr(context)),
                                content: Form(
                                  key: getIt<
                                          HospitalDonorReceivedRequestsCubit>()
                                      .formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: getIt<
                                                HospitalDonorReceivedRequestsCubit>()
                                            .reasonController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter a reason"
                                                .tr(context);
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Reason".tr(context),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (getIt<
                                                  HospitalDonorReceivedRequestsCubit>()
                                              .formKey
                                              .currentState!
                                              .validate()) {
                                            getIt<HospitalDonorReceivedRequestsCubit>()
                                                .proccessOrder(
                                              orderId!,
                                              "Rejected",
                                              reason: getIt<
                                                      HospitalDonorReceivedRequestsCubit>()
                                                  .reasonController
                                                  .text,
                                              userprofileModel:
                                                  userprofileModel!,
                                              hospitalModel:
                                                  hospitalprofileModel!,
                                            );
                                          }
                                        },
                                        child: Text("submit".tr(context)),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                    },
                    icon: const Icon(Icons.close, color: Colors.red),
                    label: Text("Reject".tr(context)),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      getIt<HospitalDonorReceivedRequestsCubit>().proccessOrder(
                        orderId!,
                        "accepted",
                        hospitalModel: hospitalprofileModel!,
                        userprofileModel: userprofileModel!,
                      );
                    },
                    icon: const Icon(Icons.check, color: Colors.green),
                    label: Text("Accept".tr(context)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonorInfoShowDialog extends StatelessWidget {
  const DonorInfoShowDialog({
    super.key,
    required this.userprofileModel,
  });
  final UserSignupModel? userprofileModel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          children: [
            Text("Donor Info".tr(context)),
            Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close))
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Personal Info".tr(context),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Name".tr(context)}: ${userprofileModel!.fullName!}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Age".tr(context)}: ${DateTime.now().year - DateTime.parse(userprofileModel!.age!).year}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Gender".tr(context)}: ${"${userprofileModel!.selectedGender!}".tr(context)}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Blood Type".tr(context)}: ${userprofileModel!.selectedBloodType!}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Phone".tr(context)}: ${userprofileModel!.phone!}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Email".tr(context)}: ${userprofileModel!.email!}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Address".tr(context)}: ${userprofileModel!.currentLocation!}"),
                  ),
                  Divider(),
                  Text("Diseases Info".tr(context),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary)),
                  Column(
                    children: userprofileModel!.diseases!.entries
                        .map((e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "${"${e.key}".tr(context)}: ${"${e.value}".tr(context)}"),
                                ),
                                Divider(),
                              ],
                            ))
                        .toList(),
                  )
                ]),
          ),
        ));
  }
}
