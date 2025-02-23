import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/core/widget/globla_textformfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_lacator.dart';
import '../../../core/enum/request_state.dart';
import '../../../core/widget/global_snackbar.dart';
import '../view_model/cubit/hospital_give_rewards_emergency_cubit.dart';

class HospitalGiveRewardsEmergency extends StatelessWidget {
  const HospitalGiveRewardsEmergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HospitalGiveRewardsEmergencyCubit,
        HospitalGiveRewardsEmergencyState>(
      bloc: getIt<HospitalGiveRewardsEmergencyCubit>(),
      listener: (context, state) {
        final cubit = getIt<HospitalGiveRewardsEmergencyCubit>();
        if (state.findUserState == RequestState.success) {
          Navigator.pop(context);

          DonorInfoAndConfirmAlert(context, cubit: cubit);
        }
      },
      builder: (context, state) {
        final cubit = getIt<HospitalGiveRewardsEmergencyCubit>();
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  "Give Emergency Rewards".tr(context),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                GlobalTextFormFiled(
                  lableText: "Donor Email".tr(context),
                  textEditingController: cubit.emailController,
                ),
                GlobalTextFormFiled(
                  keyboardType: TextInputType.number,
                  lableText: "Blood Bags Count".tr(context),
                  textEditingController: cubit.bloodBagsCountController,
                ),
                state.findUserState == RequestState.loading
                    ? Center(child: CircularProgressIndicator())
                    : GlobalButton(
                        text: "Search".tr(context),
                        onTap: () {
                          cubit.checkEmail(context);
                        })
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> DonorInfoAndConfirmAlert(BuildContext context,
      {required HospitalGiveRewardsEmergencyCubit cubit}) {
    return showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<HospitalGiveRewardsEmergencyCubit,
              HospitalGiveRewardsEmergencyState>(
            bloc: getIt<HospitalGiveRewardsEmergencyCubit>(),
            listener: (context, state) {
              if (state.userGivePoint == RequestState.success) {
                Navigator.pop(context);
                globalSnackbar(
                    context,
                    "Emergency Blood Donation Points Added Successfully"
                        .tr(context),
                    backgroundColor: Colors.green);
              } else if (state.userGivePoint == RequestState.error) {
                Navigator.pop(context);
                globalSnackbar(context,
                    "Emergency Blood Donation Points Not Added".tr(context),
                    backgroundColor: Colors.red);
              }
            },
            builder: (context, state) {
              return AlertDialog(
                title: Text("Donor Info".tr(context)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.3)),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                            "${"Name".tr(context)}: ${state.userModel!.fullName}"),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.3)),
                      child: ListTile(
                        leading: Icon(Icons.email),
                        title: Text(
                            "${"Email".tr(context)}: ${state.userModel!.email}"),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.3)),
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(
                            "${"Phone".tr(context)}: ${state.userModel!.phone}"),
                      ),
                    ),
                  ],
                ),
                actions: [
                  state.userGivePoint == RequestState.loading
                      ? Center(child: CircularProgressIndicator())
                      : TextButton(
                          onPressed: () {
                            cubit.confirm();
                          },
                          child: Text("Confirm".tr(context))),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel".tr(context)))
                ],
              );
            },
          );
        });
  }
}
