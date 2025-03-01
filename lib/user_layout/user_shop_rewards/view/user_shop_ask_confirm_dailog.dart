import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/di/service_lacator.dart';
import '../../../core/enum/request_state.dart';
import '../../../core/widget/global_snackbar.dart';
import '../../../hospital_layout/hospital_medicine_rewards/model/hospital_medicine_rewards_model.dart';
import '../../../hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import '../../user_home/view_model/cubit/user_home_cubit.dart';
import '../view_model/cubit/user_shop_rewards_cubit.dart';

Future<dynamic> userShopAskConfirmDailog(
    BuildContext context, HospitalMedicineRewardsModel model,
    {required HospitalProfileModel hospitalProfileModel}) {
  return showDialog(
      context: context,
      builder: (context) =>
          BlocConsumer<UserShopRewardsCubit, UserShopRewardsState>(
            listener: (context, state) {
              if (state.paymentsState == RequestState.error) {
                globalSnackbar(
                    context,
                    "An error occurred in the process of exchanging points"
                        .tr(context),
                    backgroundColor: Colors.red);
              }
              if (state.paymentsState == RequestState.success) {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
                getIt<UserHomeCubit>().getUserPoints();
                globalSnackbar(
                    context,
                    "The points exchange process was completed successfully"
                        .tr(context),
                    backgroundColor: Colors.blue);
              }
            },
            bloc: getIt<UserShopRewardsCubit>(),
            builder: (context, stateShop) {
              return AlertDialog(
                title: Text("Are You Sure ?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        "${"You Will Buy".tr(context)} ${model.name} ${"For".tr(context)} ${model.points} ${"Points".tr(context)}"),
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel".tr(context))),
                  stateShop.paymentsState == RequestState.loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            final userId = await Supabase
                                .instance.client.auth.currentUser!.id;

                            getIt<UserShopRewardsCubit>().buyItem(
                                hospitalOneSignalId:
                                    hospitalProfileModel.oneSignalId ?? "",
                                currentPoints: getIt<UserHomeCubit>()
                                    .state
                                    .userPointModel!
                                    .point,
                                {
                                  "user_uId": userId,
                                  "hospital_uId": hospitalProfileModel.uId,
                                  "item": model.name,
                                  "point": (model.points),
                                  "count": model.quantity!,
                                  "status": "purchased"
                                });
                          },
                          child: Text("Confirm".tr(context)))
                ],
              );
            },
          ));
}
