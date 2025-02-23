// File for class HospitalPorfileEditProfileTile

import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

import '../../../hospital_edit_profile/view/hospital_edit_profile_screen.dart';
import '../../view_model/cubit/hospital_profile_cubit.dart';

class HospitalPorfileEditProfileTile extends StatelessWidget {
  const HospitalPorfileEditProfileTile({
    super.key,
    required this.state,
  });
  final HospitalProfileState state;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Text("Edit Profile".tr(context)),
      leading: CircleAvatar(child: Icon(Icons.edit)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HospitalEditProfileScreen(
                      profile: state.hospitalProfileModel!,
                    )));
      },
    );
  }
}
