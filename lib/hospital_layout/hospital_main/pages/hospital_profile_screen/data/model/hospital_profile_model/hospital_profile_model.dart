// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final String? oneSignalId;
  const HospitalProfileModel(
      {this.id,
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
      this.oneSignalId});

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
      oneSignalId
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
      "onesignal_id": oneSignalId
    };
  }

  factory HospitalProfileModel.fromMap(Map<String, dynamic> map) {
    return HospitalProfileModel(
        id: map['id'] as int?,
        email: map['email'] as String?,
        name: map['name'] as String?,
        phone: map['phone'] as String?,
        latitude: map['latitude'] as double?,
        longitude: map['longitude'] as double?,
        currentLocation: map['currentLocation'] as String?,
        dayes: map['dayes'] as String?,
        openingTime: map['openingTime'] as String?,
        closingTime: map['closingTime'] as String?,
        docsFile: map['docsFile'] as String?,
        uId: map['uId'] as String?,
        primaryContactPerson: map['primaryContactPerson'] as String?,
        oneSignalId: map["onesignal_id"] as String?);
  }
}
