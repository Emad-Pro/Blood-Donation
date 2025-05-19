import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/locale/cubit/localizations_cubit.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_lacator.dart';
import '../view_model/cubit/hospital_give_reward_for_request_donation_cubit.dart';
import 'package:intl/intl.dart';

class HospitalGiveRewardForRequestDonation extends StatelessWidget {
  const HospitalGiveRewardForRequestDonation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Give Rewards For Request Donation".tr(context)),
      ),
      body: BlocBuilder<HospitalGiveRewardForRequestDonationCubit,
          HospitalGiveRewardForRequestDonationState>(
        bloc: getIt<HospitalGiveRewardForRequestDonationCubit>()
          ..getAcceptedRequestState(),
        builder: (context, state) {
          switch (state.getAcceptedRequestsState) {
            case RequestState.init:
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());

            case RequestState.success:
              if (state.getAcceptedRequestsModel!.isEmpty) {
                return Center(child: Text("No Accepted Requests".tr(context)));
              } else {
                return ListView.builder(
                  itemCount: state.getAcceptedRequestsModel?.length,
                  itemBuilder: (context, index) {
                    final request = state.getAcceptedRequestsModel![index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          request.userprofileModel!.profileImage!,
                        ),
                      ),
                      title: Text(
                        "${"Request a donation for".tr(context)} ${request.userprofileModel!.fullName!}",
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMEEEEd(
                          getIt<LocalizationsCubit>().state.languageCode,
                        ).format(DateTime.parse(request.createdAt!)),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              tooltip: "Confirm",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Confirm Donation"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GlobalTextFormFiled(
                                          keyboardType: TextInputType.number,
                                          lableText:
                                              "Blood Bags Count".tr(context),
                                          textEditingController: getIt<
                                                  HospitalGiveRewardForRequestDonationCubit>()
                                              .bagsController,
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: GlobalButton(
                                                text: "Confirm".tr(context),
                                                onTap: () {
                                                  getIt<HospitalGiveRewardForRequestDonationCubit>()
                                                      .confirmDonation(
                                                    id: request.id!,
                                                    context: context,
                                                    userprofileModel: request
                                                        .userprofileModel!,
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: GlobalButton(
                                                text: "Cancel".tr(context),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              icon:
                                  const Icon(Icons.check, color: Colors.green),
                            ),
                            IconButton(
                              tooltip: "Cancelled",
                              onPressed: () {
                                getIt<HospitalGiveRewardForRequestDonationCubit>()
                                    .cancelDonation(
                                  id: request.id!,
                                  context: context,
                                );
                              },
                              icon: const Icon(Icons.close, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

            case RequestState.error:
              return Center(child: Text(state.getAcceptedRequestsMessage));
          }
        },
      ),
    );
  }
}
