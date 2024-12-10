import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../user_auth/user_login/view/user_login_screen.dart';

Future<dynamic> userProfileLogoutShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            CircleAvatar(
              radius: 50,
              backgroundColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              child: Center(
                child: Icon(Icons.logout,
                    size: 55, color: Theme.of(context).colorScheme.primary),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Are you sure to log out of your account?".tr(context),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.surface),
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary)),
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) {
                        return UserLoginScreen(
                          isBack: true,
                        );
                      }),
                      (route) => false,
                    );
                  },
                  child: Text("Logout".tr(context))),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel".tr(context))),
            ),
          ]),
        );
      });
}
