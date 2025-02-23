// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:blood_donation/hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';

import '../../../../user_layout/user_auth/user_signup/model/user_signup_model.dart';

class HospitalEmergencyModel {
  final int? id;
  final UserSignupModel? userprofileModel;
  final int? points;
  final int? bloodBagsCount;
  final String? created_at;
  final HospitalProfileModel? hospitalprofileModel;

  HospitalEmergencyModel(
      {this.id,
      this.userprofileModel,
      this.points,
      this.bloodBagsCount,
      this.created_at,
      this.hospitalprofileModel});

  factory HospitalEmergencyModel.fromMap(Map<String, dynamic> map) {
    return HospitalEmergencyModel(
        id: map['id'],
        userprofileModel: UserSignupModel.fromJson(map['UserAuth']),
        points: map['point'],
        bloodBagsCount: map['blood_bags_count'],
        created_at: map['created_at'],
        hospitalprofileModel:
            HospitalProfileModel.fromMap(map["HospitalAuth"]));
  }
}
