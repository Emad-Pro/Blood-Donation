import 'package:blood_donation/core/shared_preferences/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

class AppLocaliztions {
  static Locale locale = const Locale("en");
  late Map<String, String> _localizedStrings;

  AppLocaliztions();

  static AppLocaliztions of(BuildContext context) {
    return Localizations.of<AppLocaliztions>(context, AppLocaliztions)!;
  }

  static const LocalizationsDelegate<AppLocaliztions> delegate =
      _AppLocaliztionsDelegate();

  Future<void> loadJsonLanguage() async {
    final jsonString = await rootBundle
        .loadString('assets/lang/${AppLocaliztions.locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) => _localizedStrings[key] ?? '';

  static Future<void> setLocaleCode(String localeCode) async {
    await CacheHelper.saveData(value: localeCode, key: "locale");
    AppLocaliztions.locale = Locale(localeCode);
  }

  static Future<Locale> getLocaleCode() async {
    final localeValue = await CacheHelper.getSaveData(key: 'locale');
    locale = Locale(localeValue ?? 'en');
    return locale;
  }
}

class _AppLocaliztionsDelegate extends LocalizationsDelegate<AppLocaliztions> {
  const _AppLocaliztionsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocaliztions> load(Locale locale) async {
    AppLocaliztions.locale = locale; // ضبط اللغة الثابتة هنا
    final localizations = AppLocaliztions();
    await localizations.loadJsonLanguage();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocaliztions> old) =>
      false;
}

extension TranslateX on String {
  String tr(BuildContext context) =>
      AppLocaliztions.of(context).translate(this);
}
