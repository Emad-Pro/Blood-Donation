class UserSignupModel {
  String? email;
  int? id;
  String? fullName;
  DateTime? dateLastBloodDonation; // ✅ تغيير النوع إلى DateTime
  String? phone;
  String? phoneCode;
  String? age;
  int? height;
  int? weight;
  double? latitude;
  double? longitude;
  String? currentLocation;
  String? selectedBloodType;
  String? selectedGender;
  Map<String, dynamic>? diseases;
  bool? isDisease;
  String? profileImage;
  String? uId;
  String? oneSignalId;

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
      this.uId,
      this.id,
      this.oneSignalId});

  UserSignupModel.fromJson(Map<String, dynamic> json) {
    email = json['user_email'];
    fullName = json['user_full_name'];
    if (json['user_last_dontaion'] != null) {
      if (json['user_last_dontaion'] is String) {
        try {
          dateLastBloodDonation = DateTime.parse(json['user_last_dontaion']);
        } catch (e) {
          print("Error parsing date string: $e");
        }
      } else if (json['user_last_dontaion'] is int) {
        dateLastBloodDonation =
            DateTime.fromMillisecondsSinceEpoch(json['user_last_dontaion']);
      }
    }

    phone = json['user_phone'];
    phoneCode = json['user_phone_code'];
    age = json['user_age'];
    height = json['user_height'];
    weight = json['user_weight'];
    latitude = json['user_lat'];
    longitude = json['user_long'];
    currentLocation = json['user_location_name'];
    selectedBloodType = json['user_blood_type'];
    selectedGender = json['user_gender'];
    diseases = json['user_diseases'];
    isDisease = json['is_disease'];
    profileImage = json['profile_image'];
    uId = json['uId'];
    id = json['id'];
    oneSignalId = json['onesignal_id'];
  }

  Map<String, dynamic> toJson() {
    print("Date is ${dateLastBloodDonation?.toIso8601String()}");
    return {
      'user_email': email,
      'user_full_name': fullName,
      'user_last_dontaion': dateLastBloodDonation?.toIso8601String(),
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
      'is_disease': isDisease,
      'profile_image': profileImage,
      'uId': uId,
      'onesignal_id': oneSignalId
    };
  }
}
