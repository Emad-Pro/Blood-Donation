import 'package:blood_donation/user_layout/user_shop_rewards/view/user_shop_rewards_screen.dart';
import 'package:flutter/material.dart';

import '../../../../hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import '../../../user_view_review_hospital/view/user_view_review_hospital_screen.dart';

class UserHospitalAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final HospitalProfileModel hospitalProfileModel;
  const UserHospitalAppBarWidget(
      {super.key, required this.hospitalProfileModel});
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return AppBar(
      title: Text(hospitalProfileModel.name!),
      backgroundColor: primaryColor.withOpacity(0.7),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserShopRewardsScreen(
                            hospitalProfileModel: hospitalProfileModel,
                          )));
            },
            icon: const Icon(Icons.shopify)),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserViewReviewHospitalScreen(
                          hospitalProfileModel: hospitalProfileModel)));
            },
            icon: const Icon(Icons.star_rounded)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
