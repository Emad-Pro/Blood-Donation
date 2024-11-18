import 'package:blood_donation/app/public/onboarding_screen/view/onboarding_screen.dart';
import 'package:blood_donation/core/locale/cubit/localizations_cubit.dart';
import 'package:blood_donation/core/shared_preferences/cache_helper.dart';
import 'package:blood_donation/core/style/theme/bloc/theme_bloc.dart';
import 'package:blood_donation/core/style/theme/dart_theme.dart';
import 'package:blood_donation/core/style/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/navigate_widget/onboarding_widget.dart';
import 'core/di/service_lacator.dart';
import 'core/locale/app_localiztions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await Supabase.initialize(
    url: 'https://rcmumkmvatjdvwmxprjc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJjbXVta212YXRqZHZ3bXhwcmpjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwNjQ0NDcsImV4cCI6MjA0NjY0MDQ0N30._nV4gsp7dipwWUfWejmKO3PYrituoZSpwzV3t7tl4RU',
  );
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
                  GlobalCupertinoLocalizations.delegate,
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
