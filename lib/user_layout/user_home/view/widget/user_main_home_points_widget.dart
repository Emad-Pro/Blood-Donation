import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_home/view_model/cubit/user_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_lacator.dart';
import '../../../../core/enum/request_state.dart';
import '../../data/model/user_point.dart';

class UserMainHomePointsWidget extends StatelessWidget {
  const UserMainHomePointsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Donation Points".tr(context),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  getIt<UserHomeCubit>().state.userPointState ==
                          RequestState.loading
                      ? Row(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      : Text(
                          " ${getIt<UserHomeCubit>().state.userPointModel == null ? 0 : getIt<UserHomeCubit>().state.userPointModel?.point.toString()} ",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                  Text(
                    "point".tr(context),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.bloodtype,
            color: Theme.of(context).colorScheme.primary,
            size: 45,
          )
        ],
      ),
    );
  }
}
