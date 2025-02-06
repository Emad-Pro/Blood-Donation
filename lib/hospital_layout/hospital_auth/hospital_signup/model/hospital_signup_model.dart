class HospitalSignupModel {
  final String? uId;

  final String? email;
  final String? name;
  final String? password;
  final String? phone;
  final double? latitude;
  final double? longitude;
  final String? primaryContactPerson;
  final String? currentLocation;
  final List<String>? dayes;
  final String? openingTime;
  final String? closingTime;
  final String? docsFile;
  final String? status;
  HospitalSignupModel(
      {this.uId,
      this.email,
      this.name,
      this.password,
      this.phone,
      this.latitude,
      this.longitude,
      this.primaryContactPerson,
      this.currentLocation,
      this.dayes,
      this.openingTime,
      this.closingTime,
      this.docsFile,
      this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'email': email,
      'name': name,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'primaryContactPerson': primaryContactPerson,
      'currentLocation': currentLocation,
      'dayes': dayes.toString(),
      'openingTime': openingTime,
      'closingTime': closingTime,
      'docsFile': docsFile,
      'status': status
    };
  }
}
