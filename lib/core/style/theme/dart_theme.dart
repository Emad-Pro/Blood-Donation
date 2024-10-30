import 'package:flutter/material.dart';

import '../../di/service_lacator.dart';
import '../../locale/cubit/localizations_cubit.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    textTheme: Typography().white.apply(
        fontFamily: getIt<LocalizationsCubit>().state.languageCode == "ar"
            ? "ibm"
            : "inter"),
    colorScheme: ColorScheme(
      primary: Colors.red.shade400,
      primaryContainer: Colors.red.shade900,
      secondary: Colors.blueGrey.shade300,
      secondaryContainer: Colors.blueGrey.shade700,
      surface: Colors.grey.shade900,
      error: Colors.redAccent.shade200,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white70,
      onError: Colors.black,
      brightness: Brightness.dark,
    ));
