// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class HospitalReviewModel extends Equatable {
  final int? id;
  final String? hospitalId;
  final String? hospitalName;
  final String? userName;
  final String? userId;
  final String? createdAt;
  final double? rating;
  final String? review;
  final String? userBloodType;

  HospitalReviewModel(
      {this.id,
      this.hospitalId,
      this.hospitalName,
      this.userName,
      this.userId,
      this.createdAt,
      this.rating,
      this.review,
      this.userBloodType});

  @override
  List<Object?> get props => [
        id,
        hospitalId,
        userName,
        userId,
        createdAt,
        rating,
        review,
        userBloodType
      ];

  factory HospitalReviewModel.fromMap(Map<String, dynamic> map) {
    print(map['reating']);
    return HospitalReviewModel(
      id: map['id'],
      userId: map['user_id'],
      hospitalId: map['hospital_id'],
      createdAt: map['created_at'],
      rating: map['reating'],
      review: map['review'],
      userName: map['UserAuth']['user_full_name'],
      userBloodType: map['UserAuth']['user_blood_type'],
      hospitalName: map['HospitalAuth']['name'],
    );
  }
}
