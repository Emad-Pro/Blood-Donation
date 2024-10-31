import 'package:blood_donation/core/locale/cubit/localizations_cubit.dart';
import 'package:blood_donation/core/shared_preferences/cache_helper.dart';
import 'package:blood_donation/core/style/theme/bloc/theme_bloc.dart';
import 'package:blood_donation/core/style/theme/dart_theme.dart';
import 'package:blood_donation/core/style/theme/light_theme.dart';

import 'package:blood_donation/user_layout/user_auth/user_signup/view/user_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/service_lacator.dart';
import 'core/locale/app_localiztions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator().init();
  await CacheHelper.init();

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
                locale: Locale("ar"),
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
                home: UserSignupScreen(),
              );
            },
          );
        });
  }
}
