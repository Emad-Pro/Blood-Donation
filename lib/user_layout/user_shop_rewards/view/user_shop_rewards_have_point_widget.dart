import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user_home/view_model/cubit/user_home_cubit.dart';

class UserShopRewardsHavePointsWidget extends StatelessWidget {
  const UserShopRewardsHavePointsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: BlocBuilder<UserHomeCubit, UserHomeState>(
        bloc: getIt<UserHomeCubit>()..getUserPoints(),
        builder: (context, state) {
          return Text(
              "${"You Have".tr(context)} ${getIt<UserHomeCubit>().state.userPointModel?.point} ${"point".tr(context)}");
        },
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4)),
    );
  }
}
