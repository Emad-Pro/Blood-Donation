import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/cubit/localizations_cubit.dart';
import 'package:flutter/material.dart';

ThemeData lighTheme = ThemeData.light().copyWith(
  textTheme: Typography().white.apply(
      fontFamily: getIt<LocalizationsCubit>().state.languageCode == "ar"
          ? "ibm"
          : "inter"),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme(
    primary: const Color(0xffA80000),
    primaryContainer: Colors.red.shade100,
    secondary: Colors.blueGrey.shade600,
    secondaryContainer: Colors.blueGrey.shade100,
    surface: Colors.grey.shade100,
    error: Colors.redAccent.shade400,
    onPrimary: Colors.black87,
    onSecondary: Colors.white,
    onSurface: Colors.black87,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
);
