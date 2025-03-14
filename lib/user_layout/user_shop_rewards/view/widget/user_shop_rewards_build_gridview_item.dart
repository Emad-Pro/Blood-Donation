import 'package:blood_donation/core/auto_direction.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../../core/widget/global_snackbar.dart';
import '../../../../hospital_layout/hospital_medicine_rewards/model/hospital_medicine_rewards_model.dart';
import '../../../user_home/view_model/cubit/user_home_cubit.dart';
import '../user_shop_ask_confirm_dailog.dart';
import '../user_shop_rewards_view_details_dailog.dart';

class UserShopRewardsBuildGridViewItem extends StatelessWidget {
  const UserShopRewardsBuildGridViewItem(
      {Key? key, required this.model, required this.hospitalProfileModel})
      : super(key: key);
  final HospitalMedicineRewardsModel model;
  final HospitalProfileModel hospitalProfileModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_information_rounded,
              size: 35,
            ),
            SizedBox(height: 8),
            AutoDirection(
              text: model.name!,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  model.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                userShopRewardsViewDetailsDailog(context, model);
              },
              child: Text(
                "View Details ...".tr(context),
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: .4),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            "${model.points} ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Icon(Icons.card_giftcard),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    BlocBuilder<UserHomeCubit, UserHomeState>(
                      bloc: getIt<UserHomeCubit>(),
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.primary),
                            foregroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.surface),
                          ),
                          onPressed: !(getIt<UserHomeCubit>()
                                      .state
                                      .userPointModel!
                                      .point >=
                                  model.points)
                              ? () {
                                  globalSnackbar(
                                    context,
                                    "You do not have enough points".tr(context),
                                    backgroundColor: Colors.red,
                                  );
                                }
                              : () {
                                  userShopAskConfirmDailog(
                                    hospitalProfileModel: hospitalProfileModel,
                                    context,
                                    model,
                                  );
                                },
                          child: Text("Buy".tr(context)),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
