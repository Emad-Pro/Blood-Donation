import 'package:blood_donation/hospital_layout/hospital_profile_screen/view_model/cubit/hospital_profile_cubit.dart';
import 'package:blood_donation/hospital_layout/hospital_main/view_model/cubit/hospital_main_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../hospital_layout/hospital_emergency/view_model/cubit/hospital_emergency_cubit.dart';
import '../../hospital_layout/hospital_give_Reward_for_request_donation/view_model/cubit/hospital_give_reward_for_request_donation_cubit.dart';
import '../../hospital_layout/hospital_give_rewards_emergency/view_model/cubit/hospital_give_rewards_emergency_cubit.dart';
import '../../hospital_layout/received_history_emergency_donations/view_model/cubit/hospital_donor_received_requests_page_cubit.dart';
import '../../hospital_layout/hospital_home_screen/view_model/cubit/hospital_home_cubit.dart';
import '../../user_layout/user_find/view_model/cubit/user_find_hospital_cubit.dart';
import '../../user_layout/user_profile/view_model/user_profile_cubit.dart';
import '../../user_layout/user_main/view_model/cubit/user_main_cubit.dart';
import '../locale/cubit/localizations_cubit.dart';
import '../location_service/location_service.dart';
import '../style/theme/bloc/theme_bloc.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void init() async {
    getIt.registerLazySingleton(() => ThemeCubit());
    getIt.registerLazySingleton(() => LocalizationsCubit());
    getIt.registerFactory(() => LocationService());

    ///// User
    getIt.registerLazySingleton(() => UserMainCubit());
    getIt.registerLazySingleton(() => UserProfileCubit());
    getIt.registerLazySingleton(() => UserFindHospitalCubit());

    ////// Hospital
    getIt.registerLazySingleton(() => HospitalMainCubit());
    getIt.registerLazySingleton(() => HospitalHomeCubit());
    getIt.registerLazySingleton(() => HospitalEmergencyCubit());
    getIt.registerLazySingleton(() => HospitalProfileCubit());
    getIt.registerLazySingleton(() => HospitalDonorReceivedRequestsCubit());
    getIt.registerLazySingleton(() => HospitalGiveRewardsEmergencyCubit());
    getIt.registerLazySingleton(
        () => HospitalGiveRewardForRequestDonationCubit());
  }
}
