import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../app_localiztions.dart';

class LocalizationsCubit extends Cubit<Locale> {
  LocalizationsCubit() : super(const Locale("ar")) {
    loadLanguage();
  }

  Future<void> changeLocale(Locale locale) async {
    emit(locale);
    await AppLocaliztions.setLocaleCode(locale.languageCode);
  }

  loadLanguage() async {
    final locale = await AppLocaliztions.getLocaleCode();
    emit(locale);
  }
}
