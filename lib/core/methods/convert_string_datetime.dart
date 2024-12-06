import 'package:blood_donation/core/di/service_lacator.dart';
import 'package:intl/intl.dart';

import '../locale/cubit/localizations_cubit.dart';

convertStringDateTime(String date) {
  DateTime dateTime = DateTime.parse(date);
  final getLang = getIt<LocalizationsCubit>().state.languageCode;
  return "${DateFormat.yMMMEd('${getLang}').format(dateTime)} - ${DateFormat.jm('${getLang}').format(dateTime)}";
}

convertResultDateTime(String date) {
  final getLang = getIt<LocalizationsCubit>().state.languageCode;
  final inputFormat = DateFormat('d/M/yyyy');
  final dateTime = inputFormat.parse(date);

  return DateFormat.yMMMEd('${getLang}').format(dateTime);
}
