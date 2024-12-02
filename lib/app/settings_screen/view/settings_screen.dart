import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/locale/cubit/localizations_cubit.dart';
import 'package:flutter/material.dart';

import '../../../core/style/theme/bloc/theme_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".tr(context)),
      ),
      body: Column(
        children: [
          Card(
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Icon(Icons.color_lens),
                title: Text("theme".tr(context)),
                children: [
                  ListTile(
                    selected: getIt<ThemeCubit>().state == ThemeMode.dark,
                    leading: Icon(Icons.dark_mode),
                    title: Text("Dark Mode".tr(context)),
                    onTap: () {
                      getIt<ThemeCubit>().updateTheme(ThemeMode.dark);
                    },
                  ),
                  ListTile(
                    selected: getIt<ThemeCubit>().state == ThemeMode.light,
                    leading: Icon(Icons.light_mode),
                    title: Text("Light Mode".tr(context)),
                    onTap: () {
                      getIt<ThemeCubit>().updateTheme(ThemeMode.light);
                    },
                  ),
                  ListTile(
                    selected: getIt<ThemeCubit>().state == ThemeMode.system,
                    leading: Icon(Icons.auto_awesome),
                    title: Text("System Mode".tr(context)),
                    onTap: () {
                      getIt<ThemeCubit>().updateTheme(ThemeMode.system);
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: Icon(Icons.language),
                title: Text("Language".tr(context)),
                children: [
                  ListTile(
                      selected:
                          getIt<LocalizationsCubit>().state.languageCode ==
                              'ar',
                      title: Text("Arabic".tr(context)),
                      leading: Text(" أ ب ث"),
                      onTap: () {
                        getIt<LocalizationsCubit>()
                            .changeLocale(const Locale('ar'));
                      }),
                  ListTile(
                      selected:
                          getIt<LocalizationsCubit>().state.languageCode ==
                              'en',
                      title: Text("English".tr(context)),
                      leading: Text("ABC"),
                      onTap: () {
                        getIt<LocalizationsCubit>()
                            .changeLocale(const Locale('en'));
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
