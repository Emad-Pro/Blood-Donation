import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Privacy Matters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'At GiveLife, we are committed to protecting your personal information and respecting your privacy.',
            ),
            const SizedBox(height: 20),
            const Text(
              'What We Collect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We may collect and store:\n'
              '- Your name, email address, and phone number.\n'
              '- Your location data (to connect you with nearby hospitals).\n'
              '- Donation history and eligibility details.',
            ),
            const SizedBox(height: 20),
            const Text(
              'How We Use Your Data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your information is used to:\n'
              '- Schedule and manage appointments.\n'
              '- Notify you about emergency blood donation needs.\n'
              '- Provide reminders for your next eligible donation.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Who We Share It With',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We only share your data with authorized hospitals and donation centers within your vicinity for emergency alerts and appointment scheduling.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Control',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'You can:\n'
              '- Edit or delete your account anytime.\n'
              '- Opt out of location sharing.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Questions?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('If you have concerns, contact us at [support email].'),
          ],
        ),
      ),
    );
  }
}
