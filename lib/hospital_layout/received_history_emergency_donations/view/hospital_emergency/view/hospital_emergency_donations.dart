import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/received_history_emergency_donations/view_model/cubit/hospital_donor_received_requests_page_cubit.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/di/service_lacator.dart';
import '../../../../../core/methods/calculate_distance.dart';
import '../../../model/emergency_model/hospital_emergency_model.dart';
import '../../widget/hospital_doner_build_doner_request_item.dart';

class HospitalEmergencyDonations extends StatelessWidget {
  const HospitalEmergencyDonations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalDonorReceivedRequestsCubit,
        HospitalDonorReceivedRequestsState>(
      bloc: getIt<HospitalDonorReceivedRequestsCubit>()..getEmergencyData(),
      builder: (context, state) {
        switch (state.historyEmergencyDonorState) {
          case RequestState.init:
          case RequestState.loading:
            return Center(child: CircularProgressIndicator());
          case RequestState.success:
            return state.historyEmergencyDonorModel!.isEmpty
                ? Center(child: Text("No History".tr(context)))
                : ListView.builder(
                    itemCount: state.historyEmergencyDonorModel!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return HospitalDonerBuildDonerRequestItem(
                          model: state.historyEmergencyDonorModel![index]);
                    },
                  );
          case RequestState.error:
            return Center(child: Text(state.errorMessage!));
        }
      },
    );
  }
}

class HospitalDonerBuildDonerRequestItem extends StatelessWidget {
  const HospitalDonerBuildDonerRequestItem({Key? key, required this.model})
      : super(key: key);
  final HospitalEmergencyModel model;
  @override
  Widget build(BuildContext context) {
    print(model.created_at);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "${calculateDistance(model.hospitalprofileModel!.latitude!, model.hospitalprofileModel!.longitude!, model.userprofileModel!.latitude!, model.userprofileModel!.longitude!).round()} ${"km".tr(context)}"),
                              SizedBox(height: 5),
                              Text(model.userprofileModel!.currentLocation!,
                                  style:
                                      TextStyle(fontStyle: FontStyle.italic)),
                              SizedBox(height: 5),
                              Text(
                                  "${DateFormat.yMMMd().format(DateTime.parse(model.created_at!))}"),
                              Text(
                                  "${model.bloodBagsCount} ${"bag".tr(context)}"),
                              Row(
                                children: [
                                  TextButton.icon(
                                    label: Text(
                                      "Call".tr(context),
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    onPressed: () async {
                                      await EasyLauncher.call(
                                          number:
                                              model.userprofileModel!.phone!);
                                    },
                                    icon: const Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton.icon(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              DonorInfoShowDialog(
                                                  userprofileModel:
                                                      model.userprofileModel));
                                    },
                                    icon: const Icon(
                                      Icons.info,
                                      color: Colors.blue,
                                    ),
                                    label: Text(
                                      "donor info".tr(context),
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Call Icon
                        Column(
                          children: [
                            Row(
                              children: [
                                // Donor Info Button
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ]))),
    );
  }
}
