import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'.tr(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to GiveLife'.tr(context),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('By using this app, you agree to the following terms:'
                .tr(context)),
            SizedBox(height: 20),
            Text('1. Account Use'.tr(context),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                '- Only users aged 18 and above can create accounts.- All information provided must be accurate and up-to-date.'
                    .tr(context)),
            SizedBox(height: 20),
            Text('2. Donation Eligibility'.tr(context),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'You are responsible for verifying your eligibility to donate blood as per medical guidelines.'
                    .tr(context)),
            SizedBox(height: 20),
            Text('3. Location Sharing'.tr(context),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'Location data is required to notify nearby donors and find donation centers.'
                    .tr(context)),
            SizedBox(height: 20),
            Text('4. Liability'.tr(context),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'GiveLife connects donors with hospitals and does not guarantee the safety or outcomes of donations. We are not liable for any medical or logistical issues arising from donations.'
                    .tr(context)),
            SizedBox(height: 20),
            Text('5. Updates to the App'.tr(context),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('We may modify the app features and these terms at any time.'
                .tr(context)),
            SizedBox(height: 20),
            Text('6. ${"Acceptance of the Rewards System".tr(context)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'By creating an account, you agree to participate in the rewards system, which allows you to use earned points to redeem medications at any hospital registered in the app.'
                    .tr(context)),
            SizedBox(height: 20),
            Text('7.${"Points Usability in Any Hospital".tr(context)} ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'Donors can use earned points at any hospital registered in the app, not necessarily the one where they donated, fostering collaboration between hospitals '
                    .tr(context)),
            SizedBox(height: 20),
            Text('8. ${"Medication Pickup".tr(context)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'After redeeming points for medications through the app, the donor must go to the designated hospital to pick up the medication.'
                    .tr(context)),
            SizedBox(height: 20),
            Text('9. ${"System Updates".tr(context)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'The rewards system may be updated from time to time, and users will be notified of any changes affecting how points are earned or redeemed.'
                    .tr(context)),
            SizedBox(height: 20),
            Text('Contact Us'.tr(context),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                'For questions about these terms, reach out at [support email].'
                    .tr(context)),
          ],
        ),
      ),
    );
  }
}
