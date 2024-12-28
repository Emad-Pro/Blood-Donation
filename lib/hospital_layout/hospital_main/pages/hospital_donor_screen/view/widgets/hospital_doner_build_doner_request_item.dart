import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/methods/calculate_reating.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/methods/calculate_distance.dart';
import '../../pages/hospital_donor_received_requests_page/model/hospital_donor_recevied_requests_model.dart';

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
                            SizedBox(height: 5),
                            Text(
                                "${hospitalDonorReceviedRequestsModel!.unit} ${"unit".tr(context)}"),
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
                      ],
                    ),
                  ),
                  // Call Icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
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
                                title: Text("Reject Donor"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Reason",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Submit"),
                                    )
                                  ],
                                ),
                              ));
                    },
                    icon: const Icon(Icons.close, color: Colors.red),
                    label: Text("Reject".tr(context)),
                  ),
                  TextButton.icon(
                    onPressed: () {},
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
