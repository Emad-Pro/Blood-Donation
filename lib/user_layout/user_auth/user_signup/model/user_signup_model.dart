import 'dart:io';

class UserSignupModel {
  String? email;
  String? password;
  String? confirmPassword;
  String? fullName;
  String? dateLastBloodDonation;
  String? phone;
  String? phoneCode;
  String? age;
  String? height;
  String? weight;
  String? latitude;
  String? longitude;
  String? currentLocation;
  String? selectedBloodType;
  String? selectedGender;
  Map<String, bool>? diseases;
  bool? isDisease;
  File? selectedProfileImage;

  UserSignupModel({
    this.email,
    this.password,
    this.confirmPassword,
    this.fullName,
    this.dateLastBloodDonation,
    this.phone,
    this.phoneCode,
    this.age,
    this.height,
    this.weight,
    this.latitude,
    this.longitude,
    this.currentLocation,
    this.selectedBloodType,
    this.selectedGender,
    this.diseases,
    this.isDisease,
    this.selectedProfileImage,
  });

  // Optional: You can add a method to convert from/to JSON if needed.
  factory UserSignupModel.fromJson(Map<String, dynamic> json) {
    return UserSignupModel(
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      fullName: json['fullName'],
      dateLastBloodDonation: json['dateLastBloodDonation'],
      phone: json['phone'],
      phoneCode: json['phoneCode'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      currentLocation: json['currentLocation'],
      selectedBloodType: json['selectedBloodType'],
      selectedGender: json['selectedGender'],
      diseases: json['isDisease'] == true
          ? Map<String, bool>.from(json['diseases'])
          : null,
      isDisease: json['isDisease'],
      selectedProfileImage: json['selectedProfileImage'] != null
          ? File(json['selectedProfileImage'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'fullName': fullName,
      'dateLastBloodDonation': dateLastBloodDonation,
      'phone': phone,
      'phoneCode': phoneCode,
      'age': age,
      'height': height,
      'weight': weight,
      'latitude': latitude,
      'longitude': longitude,
      'currentLocation': currentLocation,
      'selectedBloodType': selectedBloodType,
      'selectedGender': selectedGender,
      'diseases': diseases,
      'isDisease': isDisease,
      'selectedProfileImage': selectedProfileImage?.path,
    };
  }
}
