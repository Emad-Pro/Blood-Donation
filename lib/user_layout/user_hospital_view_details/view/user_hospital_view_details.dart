import 'package:flutter/material.dart';
import '../../../hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'widgets/user_hospital_app_bar_widget.dart';
import 'widgets/user_hospital_details_section.dart';
import 'widgets/user_hospital_header_section.dart';

class UserHospitalViewDetails extends StatelessWidget {
  const UserHospitalViewDetails({
    Key? key,
    required this.hospitalProfileModel,
  }) : super(key: key);

  final HospitalProfileModel hospitalProfileModel;

  @override
  Widget build(BuildContext context) {
    print(hospitalProfileModel.oneSignalId);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: UserHospitalAppBarWidget(
        hospitalProfileModel: hospitalProfileModel!,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserHospitalHeaderSection(
              primaryColor: Theme.of(context).colorScheme.primary,
              hospitalProfileModel: hospitalProfileModel,
            ),
            UserHospitalDetailsSection(
                hospitalProfileModel: hospitalProfileModel),
          ],
        ),
      ),
    );
  }
}
