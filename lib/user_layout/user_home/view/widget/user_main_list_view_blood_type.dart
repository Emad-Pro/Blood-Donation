import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/user_home_cubit.dart';
import 'build_blood_type_info_widget.dart';

class UserMainListViewBloodType extends StatelessWidget {
  const UserMainListViewBloodType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: getIt<UserHomeCubit>().bloodInfoList.length,
        itemBuilder: (context, index) {
          final list = getIt<UserHomeCubit>().bloodInfoList;
          return BuildBloodTypeInfoWidget(
            title: list[index].values.first.tr(context),
            value: list[index].keys.first.tr(context),
          );
        });
  }
}
