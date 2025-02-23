import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/hospital_layout/hospital_profile_screen/view_model/cubit/hospital_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../hospital_auth/hospital_login/view/hospital_login_screen.dart';

class HospitalReview extends StatelessWidget {
  const HospitalReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${"hello".tr(context)} ${getIt<HospitalProfileCubit>().state.hospitalProfileModel?.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
            Image.asset(
              "assets/images/hospital_images/review_ime.png",
              width: double.infinity,
              height: 200,
            ),
            Text(
              "Your Profile Is Under Review".tr(context),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            LogoutHospitalButton()
          ],
        ),
      ),
    );
  }
}

class LogoutHospitalButton extends StatelessWidget {
  const LogoutHospitalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 150,
        child: GlobalButton(
            text: "Logout".tr(context),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content:
                          Column(mainAxisSize: MainAxisSize.min, children: [
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
                          "Are you sure to log out of your account?"
                              .tr(context),
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
                                    .update({"onesignal_id": ""}).eq(
                                        "uId",
                                        getIt<HospitalProfileCubit>()
                                            .state
                                            .hospitalProfileModel!
                                            .uId
                                            .toString());
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
            }));
  }
}
