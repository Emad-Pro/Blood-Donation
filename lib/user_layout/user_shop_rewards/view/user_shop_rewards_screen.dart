import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:blood_donation/user_layout/user_shop_rewards/view_model/cubit/user_shop_rewards_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'user_shop_rewards_have_point_widget.dart';
import 'widget/user_shop_rewards_build_gridview_item.dart';

class UserShopRewardsScreen extends StatelessWidget {
  const UserShopRewardsScreen({Key? key, required this.hospitalProfileModel})
      : super(key: key);
  final HospitalProfileModel hospitalProfileModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${"Rewards Shop".tr(context)} ${hospitalProfileModel.name ?? ""}"),
      ),
      body: BlocBuilder<UserShopRewardsCubit, UserShopRewardsState>(
        bloc: UserShopRewardsCubit()
          ..getMedcineRewards(hospitalId: hospitalProfileModel.uId!),
        builder: (context, state) {
          switch (state.medicineRewardsState) {
            case RequestState.init:
            case RequestState.loading:
              return Center(child: CircularProgressIndicator());
            case RequestState.success:
              if (state.medicineRewardsModel!.isEmpty) {
                return Center(
                    child: Text("No Medicine In This Hospital".tr(context)));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 7,
                    children: [
                      UserShopRewardsHavePointsWidget(),
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 350,
                            ),
                            itemCount: state.medicineRewardsModel!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                UserShopRewardsBuildGridViewItem(
                                  hospitalProfileModel: hospitalProfileModel,
                                  model: state.medicineRewardsModel![index],
                                )),
                      ),
                    ],
                  ),
                );
              }
            case RequestState.error:
              return Text(state.medicineRewardsErrorMessage);
          }
        },
      ),
    );
  }
}
