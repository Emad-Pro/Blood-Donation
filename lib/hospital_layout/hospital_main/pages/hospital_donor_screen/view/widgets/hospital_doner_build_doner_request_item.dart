import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/methods/calculate_reating.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/di/service_lacator.dart';
import '../../../../../../core/methods/calculate_distance.dart';
import '../../pages/hospital_donor_received_requests_page/model/hospital_donor_recevied_requests_model.dart';
import '../../pages/hospital_donor_received_requests_page/view_model/cubit/hospital_donor_received_requests_page_cubit.dart';

class HospitalDonerBuildDonerRequestItem extends StatelessWidget {
  const HospitalDonerBuildDonerRequestItem(
      {super.key, required this.hospitalDonorReceviedRequestsModel});
  final HospitalDonorReceviedRequestsModel? hospitalDonorReceviedRequestsModel;
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
                              hospitalDonorReceviedRequestsModel!
                                  .userprofileModel!.selectedBloodType!,
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
                          "${"${hospitalDonorReceviedRequestsModel!.userprofileModel!.selectedGender!}".tr(context)}, ${DateTime.now().year - DateTime.parse(hospitalDonorReceviedRequestsModel!.userprofileModel!.age!).year} ${"yr old".tr(context)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(hospitalDonorReceviedRequestsModel!
                            .userprofileModel!.fullName!),
                        SizedBox(height: 5),
                        Text(
                            "${calculateDistance(hospitalDonorReceviedRequestsModel!.hospitalprofileModel!.latitude!, hospitalDonorReceviedRequestsModel!.hospitalprofileModel!.longitude!, hospitalDonorReceviedRequestsModel!.userprofileModel!.latitude!, hospitalDonorReceviedRequestsModel!.userprofileModel!.longitude!).round()} ${"km".tr(context)}"),
                        SizedBox(height: 5),
                        Text(
                          hospitalDonorReceviedRequestsModel!
                              .userprofileModel!.currentLocation!,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 5),
                        Text(
                            "${hospitalDonorReceviedRequestsModel!.unit} ${"unit".tr(context)}"),
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
                                  hospitalDonorReceviedRequestsModel:
                                      hospitalDonorReceviedRequestsModel));
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
                              number: hospitalDonorReceviedRequestsModel!
                                  .userprofileModel!.phone!);
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
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: getIt<
                                              HospitalDonorReceivedRequestsCubit>()
                                          .reasonController,
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
                                        getIt<HospitalDonorReceivedRequestsCubit>()
                                            .proccessOrder(
                                          hospitalDonorReceviedRequestsModel!
                                              .id!
                                              .toString(),
                                          "Rejected",
                                          reason: getIt<
                                                  HospitalDonorReceivedRequestsCubit>()
                                              .reasonController
                                              .text,
                                          userprofileModel:
                                              hospitalDonorReceviedRequestsModel!
                                                  .userprofileModel!,
                                          hospitalModel:
                                              hospitalDonorReceviedRequestsModel!
                                                  .hospitalprofileModel!,
                                        );
                                      },
                                      child: Text("submit".tr(context)),
                                    )
                                  ],
                                ),
                              ));
                    },
                    icon: const Icon(Icons.close, color: Colors.red),
                    label: Text("Reject".tr(context)),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      getIt<HospitalDonorReceivedRequestsCubit>().proccessOrder(
                          hospitalDonorReceviedRequestsModel!.id!.toString(),
                          "accepted",
                          hospitalModel: hospitalDonorReceviedRequestsModel!
                              .hospitalprofileModel!,
                          userprofileModel: hospitalDonorReceviedRequestsModel!
                              .userprofileModel!);
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
    required this.hospitalDonorReceviedRequestsModel,
  });
  final HospitalDonorReceviedRequestsModel? hospitalDonorReceviedRequestsModel;
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
                        "${"Name".tr(context)}: ${hospitalDonorReceviedRequestsModel!.userprofileModel!.fullName!}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Age".tr(context)}: ${DateTime.now().year - DateTime.parse(hospitalDonorReceviedRequestsModel!.userprofileModel!.age!).year}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Gender".tr(context)}: ${"${hospitalDonorReceviedRequestsModel!.userprofileModel!.selectedGender!}".tr(context)}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Blood Type".tr(context)}: ${hospitalDonorReceviedRequestsModel!.userprofileModel!.selectedBloodType!}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Phone".tr(context)}: ${hospitalDonorReceviedRequestsModel!.userprofileModel!.phone!}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Email".tr(context)}: ${hospitalDonorReceviedRequestsModel!.userprofileModel!.email!}"),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${"Address".tr(context)}: ${hospitalDonorReceviedRequestsModel!.userprofileModel!.currentLocation!}"),
                  ),
                  Divider(),
                  Text("Diseases Info".tr(context),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary)),
                  Column(
                    children: hospitalDonorReceviedRequestsModel!
                        .userprofileModel!.diseases!.entries
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
