// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class HospitalProfileModel extends Equatable {
  final int? id;
  final String? email;
  final String? name;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final String? currentLocation;
  final String? dayes;
  final String? openingTime;
  final String? closingTime;
  final String? docsFile;
  final String? uId;
  final String? primaryContactPerson;

  const HospitalProfileModel({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.latitude,
    this.longitude,
    this.currentLocation,
    this.dayes,
    this.openingTime,
    this.closingTime,
    this.docsFile,
    this.uId,
    this.primaryContactPerson,
  });

  @override
  List<Object?> get props {
    return [
      id,
      email,
      name,
      phone,
      latitude,
      longitude,
      currentLocation,
      dayes,
      openingTime,
      closingTime,
      docsFile,
      uId,
      primaryContactPerson,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'currentLocation': currentLocation,
      'dayes': dayes,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'docsFile': docsFile,
      'uId': uId,
      'primaryContactPerson': primaryContactPerson,
    };
  }

  factory HospitalProfileModel.fromMap(Map<String, dynamic> map) {
    return HospitalProfileModel(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      currentLocation: map['currentLocation'] != null
          ? map['currentLocation'] as String
          : null,
      dayes: map['dayes'] != null ? map['dayes'] as String : null,
      openingTime:
          map['openingTime'] != null ? map['openingTime'] as String : null,
      closingTime:
          map['closingTime'] != null ? map['closingTime'] as String : null,
      docsFile: map['docsFile'] != null ? map['docsFile'] as String : null,
      uId: map['uId'] != null ? map['uId'] as String : null,
      primaryContactPerson: map['primaryContactPerson'] != null
          ? map['primaryContactPerson'] as String
          : null,
    );
  }
}
