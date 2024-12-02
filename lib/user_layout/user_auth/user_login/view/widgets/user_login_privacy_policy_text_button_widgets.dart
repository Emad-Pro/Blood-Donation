import 'package:blood_donation/app/privacy_policy/view/privacy_policy.dart';
import 'package:blood_donation/app/terms_and_conditions/view/terms_and_conditions.dart';
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TermsAndConditionsScreen()));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyScreen()));
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
