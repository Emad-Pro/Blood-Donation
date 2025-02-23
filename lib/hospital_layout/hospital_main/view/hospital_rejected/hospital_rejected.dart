import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_button.dart';
import 'package:blood_donation/hospital_layout/hospital_edit_profile/view/hospital_edit_profile_screen.dart';
import 'package:blood_donation/hospital_layout/hospital_profile_screen/view_model/cubit/hospital_profile_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/service_lacator.dart';
import '../hospital_review/hospital_review.dart';

class HospitalRejected extends StatelessWidget {
  const HospitalRejected({Key? key}) : super(key: key);

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
              "assets/images/hospital_images/rejected_ime.png",
              width: double.infinity,
              height: 200,
            ),
            Text(
              "Rejected".tr(context),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
            Text("Your Profile Is Rejected".tr(context)),
            Row(
              children: [
                LogoutHospitalButton(),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: GlobalButton(
                      text: "Edit Data".tr(context),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HospitalEditProfileScreen(
                              profile: getIt<HospitalProfileCubit>()
                                  .state
                                  .hospitalProfileModel!);
                        }));
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
