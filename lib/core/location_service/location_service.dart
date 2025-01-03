import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../hospital_layout/hospital_main/pages/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import '../methods/calculate_distance.dart';

class LocationService {
  Future<bool> checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<Position?> getCurrentLocation() async {
    bool hasPermission = await checkAndRequestPermission();

    if (!hasPermission) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> getAddressFromCoordinates(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    print(placemarks[0]);
    Placemark place = placemarks[0];
    return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
  }

  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  List<HospitalProfileModel> filterLocationsByDistance(
      double userLat,
      double userLon,
      double maxDistance,
      List<HospitalProfileModel> locations) {
    return locations.where((location) {
      if (location.latitude == null || location.longitude == null) {
        return false;
      }
      double distance = calculateDistance(
          userLat, userLon, location.longitude!, location.latitude!);

      print(distance <= ((maxDistance.toInt()) + .5));
      return distance <= ((maxDistance.toInt()) + .5);
    }).toList();
  }
}
