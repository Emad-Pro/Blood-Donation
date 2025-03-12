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
              return Center(
                child: CircularProgressIndicator(),
              );
            case RequestState.success:
              if (state.getAcceptedRequestsModel!.isEmpty) {
                return Center(child: Text("No Accepted Requests".tr(context)));
              } else
                return ListView.builder(
                    itemCount: state.getAcceptedRequestsModel?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(state
                              .getAcceptedRequestsModel![index]
                              .userprofileModel!
                              .profileImage!),
                        ),
                        trailing: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Confirm Donation"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GlobalTextFormFiled(
                                              keyboardType:
                                                  TextInputType.number,
                                              lableText: "Blood Bags Count"
                                                  .tr(context),
                                              textEditingController: getIt<
                                                      HospitalGiveRewardForRequestDonationCubit>()
                                                  .bagsController,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            state.confirmRequestState ==
                                                    RequestState.loading
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : Row(
                                                    children: [
                                                      Expanded(
                                                        child: GlobalButton(
                                                            text: "Confirm"
                                                                .tr(context),
                                                            onTap: () {
                                                              getIt<HospitalGiveRewardForRequestDonationCubit>().confirmDonation(
                                                                  id: state
                                                                      .getAcceptedRequestsModel![
                                                                          index]
                                                                      .id!,
                                                                  context:
                                                                      context,
                                                                  userprofileModel: state
                                                                      .getAcceptedRequestsModel![
                                                                          index]
                                                                      .userprofileModel!);
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        child: GlobalButton(
                                                            text: "Cancel"
                                                                .tr(context),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                      ),
                                                    ],
                                                  )
                                          ],
                                        ),
                                      ));
                            },
                            child: Text("Confirm".tr(context))),
                        subtitle: Text(DateFormat.yMMMMEEEEd(
                                getIt<LocalizationsCubit>().state.languageCode)
                            .format(DateTime.parse(state
                                .getAcceptedRequestsModel![index].createdAt!))),
                        title: Text(
                            "${"Request a donation for".tr(context)} ${state.getAcceptedRequestsModel![index].userprofileModel!.fullName!}"),
                      );
                    });

            case RequestState.error:
              return Text(state.getAcceptedRequestsMessage);
          }
        },
      ),
    );
  }
}






//accepted