import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../user_signup/view/user_signup_screen.dart';

class UserLoginDontHaveAccountWidgets extends StatelessWidget {
  const UserLoginDontHaveAccountWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text:
                  "You don't have an account yet. Do you want to register an account?"
                      .tr(context),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            TextSpan(
              text: "Sign Up".tr(context),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserSignupScreen(),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
