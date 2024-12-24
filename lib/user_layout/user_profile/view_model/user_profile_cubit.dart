import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/user_layout/user_auth/user_signup/model/user_signup_model.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileState());
  final supabase = Supabase.instance.client;
  getUserProfile() async {
    emit(state.copyWith(userProfileState: RequestState.loading));
    try {
      final result = await supabase
          .from("UserAuth")
          .select()
          .eq("uId", supabase.auth.currentUser!.id);
      print(result);
      emit(state.copyWith(
          userProfileState: RequestState.success,
          userSignupModel: UserSignupModel.fromJson(result[0])));
    } on PostgrestException catch (e) {
      emit(state.copyWith(
          userProfileState: RequestState.error, errorMessage: e.message));
    } on AuthException catch (e) {
      emit(state.copyWith(
          userProfileState: RequestState.error, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          userProfileState: RequestState.error, errorMessage: e.toString()));
    }
  }
}
