import 'package:get_it/get_it.dart';

import '../locale/cubit/localizations_cubit.dart';
import '../style/theme/bloc/theme_bloc.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void init() async {
    getIt.registerLazySingleton(() => ThemeCubit());
    getIt.registerLazySingleton(() => LocalizationsCubit());
  }
}
