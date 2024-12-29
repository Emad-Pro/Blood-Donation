import 'package:equatable/equatable.dart';
import '../../../../../../../user_layout/user_auth/user_signup/model/user_signup_model.dart';
import '../../../../hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';

class HospitalDonorReceviedRequestsModel extends Equatable {
  final int? id;
  final UserSignupModel? userprofileModel;
  final HospitalProfileModel? hospitalprofileModel;
  final String? time;
  final String? status;
  final String? point;
  final double? unit;
  final String? createdAt;
  final String? day;
  final String? reason;

  const HospitalDonorReceviedRequestsModel(
      {this.time,
      this.status,
      this.point,
      this.unit,
      this.userprofileModel,
      this.createdAt,
      this.hospitalprofileModel,
      this.day,
      this.id,
      this.reason});
  @override
  List<Object?> get props {
    return [
      id,
      time,
      day,
      status,
      point,
      unit,
      userprofileModel,
      createdAt,
      hospitalprofileModel,
      reason
    ];
  }

  factory HospitalDonorReceviedRequestsModel.fromMap(Map<String, dynamic> map) {
    return HospitalDonorReceviedRequestsModel(
      id: map['id'],
      userprofileModel: UserSignupModel.fromJson(map['UserAuth']),
      hospitalprofileModel: HospitalProfileModel.fromMap(map['HospitalAuth']),
      createdAt: map['created_at'],
      time: map['time'],
      status: map['status'],
      point: map['point'],
      unit: map['unit'],
      day: map['day'],
      reason: map['reason'],
    );
  }
}
