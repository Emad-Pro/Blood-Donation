import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/hospital_layout/hospital_auth/hospital_login/view/hospital_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HospitalProfileLogoutTile extends StatelessWidget {
  const HospitalProfileLogoutTile({super.key, required this.userUid});
  final String userUid;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Text("Logout".tr(context)),
      leading: CircleAvatar(child: Icon(Icons.logout)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.1),
                    child: Center(
                      child: Icon(Icons.logout,
                          size: 55,
                          color: Theme.of(context).colorScheme.primary),
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

                          await OneSignal.logout();
                          await Supabase.instance.client
                              .from("HospitalAuth")
                              .update({"onesignal_id": ""}).eq("uId", userUid);
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (builder) {
                            return HospitalLoginScreen(
                              isBack: true,
                            );
                          }), (route) => false);
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
      },
    );
  }
}
