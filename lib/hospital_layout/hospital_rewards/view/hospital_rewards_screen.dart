import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../hospital_give_Reward_for_request_donation/view/hospital_give_Reward_for_request_donation.dart';
import '../../hospital_give_rewards_emergency/view/hospital_give_rewards_emergency.dart';

class HospitalRewardsScreen extends StatelessWidget {
  const HospitalRewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rewards".tr(context))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 5,
          children: [
            ListTile(
              title: Text("Give Rewards For Emergency Donation".tr(context)),
              leading: CircleAvatar(child: Icon(Icons.handshake)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
                size: 16,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          contentPadding: EdgeInsets.all(0.0),
                          content: SizedBox(
                              //   height: MediaQuery.sizeOf(context).height * 0.6,
                              child: HospitalGiveRewardsEmergency()),
                        ));
              },
            ),
            ListTile(
              title: Text("Give Rewards For Request Donation".tr(context)),
              leading: CircleAvatar(child: Icon(Icons.domain_verification)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
                size: 16,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HospitalGiveRewardForRequestDonation();
                }));
              },
            ),
            ListTile(
              title: Text("List of donation awards".tr(context)),
              leading: CircleAvatar(child: Icon(Icons.card_giftcard)),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
                size: 16,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
