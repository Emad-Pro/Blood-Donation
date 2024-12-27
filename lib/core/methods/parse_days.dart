import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:flutter/material.dart';

List<String> parseDays(String? days, BuildContext context) {
  if (days == null || days.isEmpty) {
    return [];
  }
  try {
    return days
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(',')
        .map((e) => e.trim().tr(context))
        .toList();
  } catch (e) {
    print('Error parsing days: $e');
    return [];
  }
}
