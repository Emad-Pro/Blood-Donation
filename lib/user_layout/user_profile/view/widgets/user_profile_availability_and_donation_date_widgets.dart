import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_profile/view_model/user_profile_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../core/methods/convert_string_datetime.dart';

class UserProfileAvailabilityAndDonationDateWidgets extends StatelessWidget {
  const UserProfileAvailabilityAndDonationDateWidgets(
      {super.key, required this.state});
  final UserProfileState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ListTile(
        //   leading: Switch(
        //     value: true,
        //     onChanged: (value) {},
        //     activeColor: Theme.of(context).colorScheme.primary,
        //   ),
        //   title: Text(
        //     "I am available to donate".tr(context),
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 16,
        //     ),
        //   ),
        // ),

        // Donation Date Section
        ListTile(
          leading: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  //   alignment: WrapAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      state.userSignupModel!.dateLastBloodDonation!.day
                          .toString(),
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ]),
              Icon(
                Icons.calendar_today,
                color: Theme.of(context).colorScheme.primary,
                size: 50,
              ),
            ],
          ),
          title: Text(
            "Date of last blood donation".tr(context),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(convertResultDateTime(
              state.userSignupModel!.dateLastBloodDonation!)),
          // trailing: Icon(Icons.arrow_forward_ios,
          //     color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
        ),

        Divider(),
      ],
    );
  }
}
