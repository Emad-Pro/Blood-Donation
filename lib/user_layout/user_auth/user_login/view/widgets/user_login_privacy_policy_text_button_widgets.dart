import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UserLoginPrivacyPolicyTextButtonWidgets extends StatelessWidget {
  const UserLoginPrivacyPolicyTextButtonWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "By logging, you agree to our".tr(context),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                TextSpan(
                  text: "Terms & Conditions".tr(context),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Terms & Conditions tap
                    },
                ),
                TextSpan(
                  text: "and".tr(context),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                TextSpan(
                  text: "PrivacyPolicy.".tr(context),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Handle Privacy Policy tap
                    },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
