import 'dart:math';

import '../../hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadius = 6371; // نصف قطر الأرض بالكيلومترات

  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) *
          cos(_degreesToRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c; // المسافة بالكيلومترات
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

List<HospitalProfileModel> filterLocationsByDistance(double userLat,
    double userLon, double maxDistance, List<HospitalProfileModel> locations) {
  return locations.where((location) {
    if (location.latitude == null || location.longitude == null) {
      return false;
    }
    double distance = calculateDistance(
        userLat, userLon, location.latitude!, location.longitude!);
    return distance <= maxDistance; // التحقق من المسافة
  }).toList();
}
