import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_profile_screen/view_model/cubit/hospital_profile_cubit.dart';
import 'package:blood_donation/hospital_layout/hospital_main/view_model/cubit/hospital_main_cubit.dart';
import 'package:get_it/get_it.dart';

import '../locale/cubit/localizations_cubit.dart';
import '../location_service/location_service.dart';
import '../style/theme/bloc/theme_bloc.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void init() async {
    getIt.registerLazySingleton(() => ThemeCubit());
    getIt.registerLazySingleton(() => LocalizationsCubit());
    getIt.registerFactory(() => LocationService());

    ////// Hospital
    getIt.registerLazySingleton(() => HospitalMainCubit());
    getIt.registerLazySingleton(() => HospitalProfileCubit());
  }
}
