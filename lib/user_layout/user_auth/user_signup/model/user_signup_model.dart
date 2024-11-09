import 'dart:io';

class UserSignupModel {
  String? email;

  String? fullName;
  String? dateLastBloodDonation;
  String? phone;
  String? phoneCode;
  int? age;
  int? height;
  int? weight;
  double? latitude;
  double? longitude;
  String? currentLocation;
  String? selectedBloodType;
  String? selectedGender;
  Map<String, bool>? diseases;
  bool? isDisease;
  String? profileImage;
  String? uId;

  UserSignupModel(
      {this.email,
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
      this.profileImage,
      this.uId});

  Map<String, dynamic> toJson() {
    return {
      'user_email': email,
      'user_full_name': fullName,
      'user_last_dontaion': dateLastBloodDonation,
      'user_phone': "${phoneCode}${phone}",
      'user_age': age,
      'user_height': height,
      'user_weight': weight,
      'user_lat': latitude,
      'user_long': longitude,
      'user_location_name': currentLocation,
      'user_blood_type': selectedBloodType,
      'user_gender': selectedGender,
      'user_diseases': diseases,
      //  'isDisease': false,
      'profile_image': profileImage,

      'uId': uId
    };
  }
}
