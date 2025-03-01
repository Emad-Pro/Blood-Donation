import 'package:blood_donation/hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';

class UserPaymentsModel {
  final int? id;
  final String? item;
  final int? points;
  final DateTime? createdAt;
  final HospitalProfileModel? hospitalProfileModel;
  final String? status;
  final int? count;

  UserPaymentsModel(
      {this.id,
      this.item,
      this.points,
      this.createdAt,
      this.hospitalProfileModel,
      this.status,
      this.count});

  factory UserPaymentsModel.fromJson(Map<String, dynamic> json) {
    return UserPaymentsModel(
      id: json['id'],
      item: json['item'],
      points: json['point'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      hospitalProfileModel: json['hospital_profile'] != null
          ? HospitalProfileModel.fromMap(json['hospital_profile'])
          : null,
      status: json['status'],
      count: json['count'],
    );
  }
}
