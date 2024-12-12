import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/google_maps/google_maps_screen.dart';
import '../../../../hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import '../../view_model/cubit/user_hospital_view_details_cubit.dart';
import 'user_hospital_detail_tiles.dart';
import 'user_hospital_header_row.dart';

class UserHospitalDetailsSection extends StatelessWidget {
  const UserHospitalDetailsSection(
      {Key? key, required this.hospitalProfileModel})
      : super(key: key);

  final HospitalProfileModel hospitalProfileModel;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return BlocProvider(
      create: (context) => UserHospitalViewDetailsCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHospitalHeaderRow(
                hospitalProfileModel: hospitalProfileModel,
                primaryColor: primaryColor),
            UserHospitalDetailTiles(
                hospitalProfileModel: hospitalProfileModel,
                primaryColor: primaryColor),
            SizedBox(
              height: 600,
              child: GoogleMapsScreen(
                longitude: hospitalProfileModel.latitude!,
                latitude: hospitalProfileModel.longitude!,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
