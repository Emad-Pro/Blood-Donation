import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/cubit/localizations_cubit.dart';
import 'package:flutter/material.dart';

import '../../../core/style/theme/bloc/theme_bloc.dart';

class SettignsScreen extends StatelessWidget {
  const SettignsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          ExpansionTile(
            title: Text("Theme Mode"),
            children: [
              ListTile(
                selected: getIt<ThemeCubit>().state == ThemeMode.dark,
                leading: Icon(Icons.dark_mode),
                title: Text("Dark Mode"),
                onTap: () {
                  getIt<ThemeCubit>().updateTheme(ThemeMode.dark);
                },
              ),
              ListTile(
                selected: getIt<ThemeCubit>().state == ThemeMode.light,
                leading: Icon(Icons.light_mode),
                title: Text("Light Mode"),
                onTap: () {
                  getIt<ThemeCubit>().updateTheme(ThemeMode.light);
                },
              ),
              ListTile(
                selected: getIt<ThemeCubit>().state == ThemeMode.system,
                leading: Icon(Icons.auto_awesome),
                title: Text("System Mode"),
                onTap: () {
                  getIt<ThemeCubit>().updateTheme(ThemeMode.system);
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Language"),
            children: [
              ListTile(
                  selected:
                      getIt<LocalizationsCubit>().state.languageCode == 'ar',
                  title: Text("Arabic"),
                  leading: Text(" أ ب ث"),
                  onTap: () {
                    getIt<LocalizationsCubit>()
                        .changeLocale(const Locale('ar'));
                  }),
              ListTile(
                  selected:
                      getIt<LocalizationsCubit>().state.languageCode == 'en',
                  title: Text("English"),
                  leading: Text("ABC"),
                  onTap: () {
                    getIt<LocalizationsCubit>()
                        .changeLocale(const Locale('en'));
                  })
            ],
          )
        ],
      ),
    );
  }
}
