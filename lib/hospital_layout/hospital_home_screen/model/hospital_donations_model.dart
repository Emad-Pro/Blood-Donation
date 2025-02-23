import 'package:equatable/equatable.dart';

class HospitalDonationsModel extends Equatable {
  final String? createdAt;
  final String? bloodType;
  final String? donerId;
  final String? hospitalId;
  final String? donerName;
  final bool? requestOrder;

  HospitalDonationsModel(
      {this.createdAt,
      this.bloodType,
      this.donerId,
      this.hospitalId,
      this.donerName,
      this.requestOrder});

  @override
  List<Object?> get props => [
        createdAt,
        bloodType,
        donerId,
        hospitalId,
        donerName,
        requestOrder,
      ];

  factory HospitalDonationsModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return HospitalDonationsModel(
      createdAt: json['created_at'],
      bloodType: json['UserAuth']['user_blood_type'],
      donerId: json['donaer_id'],
      hospitalId: json['hospital_id'],
      donerName: json['UserAuth']['user_full_name'],
      requestOrder: json['request'],
    );
  }
}
