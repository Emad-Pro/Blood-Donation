import 'package:equatable/equatable.dart';

class HospitalMedicineRewardsModel extends Equatable {
  final int? id;
  final String? name;
  final int? quantity;
  final String? description;
  final dynamic points;
  final String? uId;

  HospitalMedicineRewardsModel({
    this.id,
    this.name,
    this.quantity,
    this.description,
    this.points,
    this.uId,
  });
  factory HospitalMedicineRewardsModel.fromJson(Map<String, dynamic> json) {
    return HospitalMedicineRewardsModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      description: json['description'],
      points: json['points'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantity,
      'description': description,
      'points': points,
      'uId': uId
    };
  }

  @override
  List<Object?> get props => [id, name, quantity, description, points, uId];
}
