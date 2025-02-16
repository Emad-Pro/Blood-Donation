import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:intl/intl.dart';

import '../locale/cubit/localizations_cubit.dart';

convertStringDateTime(String date) {
  DateTime dateTime = DateTime.parse(date);
  final getLang = getIt<LocalizationsCubit>().state.languageCode;
  return "${DateFormat.yMMMEd('${getLang}').format(dateTime)} - ${DateFormat.jm('${getLang}').format(dateTime)}";
}

convertResultDateTime(DateTime date) {
  final getLang = getIt<LocalizationsCubit>().state.languageCode;

  return DateFormat.yMMMEd('${getLang}').format(date);
}
