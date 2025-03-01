import 'package:blood_donation/hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/model/user_signup_model.dart';

class HospitalExchangedModel {
  final int? id;
  final String? name;
  final DateTime? createdAt;
  final int? count;
  final String? status;
  final UserSignupModel? userSignupModel;
  final HospitalProfileModel? hospitalProfileModel;

  HospitalExchangedModel({
    this.id,
    this.name,
    this.createdAt,
    this.count,
    this.status,
    this.userSignupModel,
    this.hospitalProfileModel,
  });

  factory HospitalExchangedModel.fromJson(Map<String, dynamic> json) {
    return HospitalExchangedModel(
      id: json['id'],
      name: json['item'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      count: json['count'],
      status: json['status'],
      userSignupModel: json['UserAuth'] != null
          ? UserSignupModel.fromJson(json['UserAuth'])
          : null,
      hospitalProfileModel: json['HospitalAuth'] != null
          ? HospitalProfileModel.fromMap(json['HospitalAuth'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['count'] = count;
    data['status'] = status;
    data['UserAuth'] = userSignupModel?.toJson();
    data['HospitalAuth'] = hospitalProfileModel?.toMap();
    return data;
  }
}
