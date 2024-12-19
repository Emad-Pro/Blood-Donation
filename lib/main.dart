import 'dart:async';

import 'package:blood_donation/core/locale/cubit/localizations_cubit.dart';
import 'package:blood_donation/core/shared_preferences/cache_helper.dart';
import 'package:blood_donation/core/style/theme/bloc/theme_bloc.dart';
import 'package:blood_donation/core/style/theme/dart_theme.dart';
import 'package:blood_donation/core/style/theme/light_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'app/navigate_widget/onboarding_widget.dart';
import 'core/di/service_lacator.dart';
import 'core/locale/app_localiztions.dart';
import 'core/location_service/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // تسجيل المهمة الدورية
  await Workmanager().registerPeriodicTask(
      "1", // معرف المهمة (يجب أن يكون فريدًا)
      taskName,
      frequency: Duration(minutes: 15));
  await Supabase.initialize(
      url: 'https://rcmumkmvatjdvwmxprjc.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJjbXVta212YXRqZHZ3bXhwcmpjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwNjQ0NDcsImV4cCI6MjA0NjY0MDQ0N30._nV4gsp7dipwWUfWejmKO3PYrituoZSpwzV3t7tl4RU');
  await CacheHelper.init();
  OnBoardingSkip.initCheckBoarding();

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationsCubit, Locale>(
        bloc: getIt<LocalizationsCubit>(),
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            bloc: getIt<ThemeCubit>(),
            builder: (context, themeMode) {
              return MaterialApp(
                locale: locale,
                supportedLocales: const [Locale('en'), Locale('ar')],
                localizationsDelegates: const [
                  AppLocaliztions.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                debugShowCheckedModeBanner: false,
                theme: lighTheme,
                darkTheme: darkTheme,
                themeMode: themeMode,
                home: OnBoardingSkip.WidgetIntApp(),
              );
            },
          );
        });
  }
}

// اسم المهمة
const String taskName = "updateLocationTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final supabase = await Supabase.instance.client.auth.currentUser;
    if (supabase != null &&
        supabase.identities != null &&
        supabase.identities!.isNotEmpty &&
        supabase.identities!.first.identityData != null &&
        supabase.identities!.first.identityData!['roule'] == 'user') {
      print("Executing background task in WorkManager...");
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Error: خدمة الموقع غير مفعلة");
        return Future.value(false);
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print("Error: الصلاحيات مرفوضة");
        return Future.value(false);
      }
      try {
        await Supabase.initialize(
            url: 'https://rcmumkmvatjdvwmxprjc.supabase.co',
            anonKey:
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJjbXVta212YXRqZHZ3bXhwcmpjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwNjQ0NDcsImV4cCI6MjA0NjY0MDQ0N30._nV4gsp7dipwWUfWejmKO3PYrituoZSpwzV3t7tl4RU');

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        final location = LocationService().getAddressFromCoordinates(position);

        await Supabase.instance.client.from("UserAuth").update({
          "user_long": position.longitude.toString(),
          "user_lat": position.latitude.toString(),
          "user_location_name": location
        }).eq("uId", supabase.id);
        return Future.value(true);
      } catch (e) {
        return Future.value(false);
      }
    }
    return Future.value(false);
  });
}
