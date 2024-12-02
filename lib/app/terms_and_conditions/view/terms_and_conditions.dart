import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to GiveLife',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'By using this app, you agree to the following terms:',
            ),
            const SizedBox(height: 20),
            const Text(
              '1. Account Use',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Only users aged 18 and above can create accounts.\n'
              '- All information provided must be accurate and up-to-date.',
            ),
            const SizedBox(height: 20),
            const Text(
              '2. Donation Eligibility',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'You are responsible for verifying your eligibility to donate blood as per medical guidelines.',
            ),
            const SizedBox(height: 20),
            const Text(
              '3. Location Sharing',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Location data is required to notify nearby donors and find donation centers.',
            ),
            const SizedBox(height: 20),
            const Text(
              '4. Liability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'GiveLife connects donors with hospitals and does not guarantee the safety or outcomes of donations. '
              'We are not liable for any medical or logistical issues arising from donations.',
            ),
            const SizedBox(height: 20),
            const Text(
              '5. Updates to the App',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We may modify the app features and these terms at any time.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
                'For questions about these terms, reach out at [support email].'),
          ],
        ),
      ),
    );
  }
}
