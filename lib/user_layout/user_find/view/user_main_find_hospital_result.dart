import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/methods/calculate_distance.dart';
import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'package:blood_donation/user_layout/user_profile/view_model/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import '../../user_hospital_view_details/view/user_hospital_view_details.dart';

class UserMainFindHospitalResult extends StatelessWidget {
  const UserMainFindHospitalResult({
    Key? key,
    required this.searchResult,
  }) : super(key: key);
  final List<HospitalProfileModel> searchResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hospital Search Result".tr(context),
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Center(
        child: searchResult.length == 0
            ? Text("No Result", style: TextStyle())
            : ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserHospitalViewDetails(
                            hospitalProfileModel: searchResult[index],
                          ),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      child: Icon(Icons.local_hospital),
                    ),
                    title: Text(searchResult[index].name!),
                    subtitle: Text(
                      searchResult[index].currentLocation!,
                      maxLines: 1,
                    ),
                    trailing: Text(
                      "${calculateDistance(
                        searchResult[index].latitude!,
                        searchResult[index].longitude!,
                        getIt<UserProfileCubit>()
                            .state
                            .userSignupModel!
                            .latitude!,
                        getIt<UserProfileCubit>()
                            .state
                            .userSignupModel!
                            .longitude!,
                      ).ceil().toString()} ${"km".tr(context)}",
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
