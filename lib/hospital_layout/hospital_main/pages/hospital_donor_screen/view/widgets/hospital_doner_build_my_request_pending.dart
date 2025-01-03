import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../core/methods/calculate_distance.dart';
import '../../pages/hospital_donor_received_requests_page/model/hospital_donor_recevied_requests_model.dart';
import 'hospital_doner_build_doner_request_item.dart';

class HospitalDonerBuildMyRequestPending extends StatelessWidget {
  const HospitalDonerBuildMyRequestPending({super.key, required this.model});
  final HospitalDonorReceviedRequestsModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Blood Group Widget
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(),
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
                              model.userprofileModel!.selectedBloodType!,
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
                          "${"${model.userprofileModel!.selectedGender!}".tr(context)}, ${DateTime.now().year - DateTime.parse(model.userprofileModel!.age!).year} ${"yr old".tr(context)}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(model.userprofileModel!.fullName!),
                        SizedBox(height: 5),
                        Text(
                            "${calculateDistance(model.hospitalprofileModel!.latitude!, model.hospitalprofileModel!.longitude!, model.userprofileModel!.latitude!, model.userprofileModel!.longitude!)} ${"km".tr(context)}"),
                        SizedBox(height: 5),
                        Text(model.userprofileModel!.currentLocation!,
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        SizedBox(height: 5),
                        //   Text("${model.unit} ${"unit".tr(context)}"),
                      ],
                    ),
                  ),
                  // Call Icon
                  IconButton(
                    onPressed: () async {
                      await EasyLauncher.call(
                          number: model.hospitalprofileModel!.phone!);
                    },
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              if (model.status == "accepted" || model.status == "canceled")
                Row(
                  children: [
                    Row(
                      children: [
                        model.status == "accepted"
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.close, color: Colors.orange),
                        const SizedBox(width: 5),
                        if (model.status == "accepted")
                          Text(
                            "Request accepted".tr(context),
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (model.status == "canceled")
                          Text(
                            "Canceled By Donor".tr(context),
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        // Donor Info Button
                        TextButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => DonorInfoShowDialog(
                                    hospitalDonorReceviedRequestsModel: model));
                          },
                          icon: const Icon(
                            Icons.info,
                            color: Colors.blue,
                          ),
                          label: Text(
                            "donor info".tr(context),
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              if (model.status == "Rejected")
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.close, color: Colors.red),
                        const SizedBox(width: 5),
                        Text(
                          "Request Rejected".tr(context),
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        // Donor Info Button
                        TextButton.icon(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => DonorInfoShowDialog(
                                    hospitalDonorReceviedRequestsModel: model));
                          },
                          icon: const Icon(
                            Icons.info,
                            color: Colors.blue,
                          ),
                          label: Text(
                            "donor info".tr(context),
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
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
