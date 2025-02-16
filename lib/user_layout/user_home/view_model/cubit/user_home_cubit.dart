import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/user_layout/user_home/data/model/user_point.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_home_state.dart';

class UserHomeCubit extends Cubit<UserHomeState> {
  UserHomeCubit() : super(UserHomeState());
  final List<Map<String, String>> bloodInfoList = [
    {
      "Blood Type A": "Type A",
    },
    {
      "Blood Type B": "Type B",
    },
    {
      "Blood Type AB": "Type AB",
    },
    {
      "Blood Type O": "Type O",
    },
    {
      "Blood Type O Negative (O-)": "Type O Negative (O-)",
    },
    {
      "Blood Type AB Positive (AB+)": "Type AB Positive (AB+)",
    },
    {
      "notes": "notes_blood",
    }
  ];

  getUserPoints() async {
    emit(state.copyWith(userPointState: RequestState.loading));
    final supabase = Supabase.instance.client;
    final userID = supabase.auth.currentUser!.id;
    await supabase
        .from("donation_point")
        .select()
        .eq("uId", userID)
        .then((onValue) {
      if (onValue.isNotEmpty) {
        emit(state.copyWith(
            userPointModel: UserPointModel.fromJson(onValue[0]),
            userPointState: RequestState.success));
      } else {
        emit(state.copyWith(
            userPointModel:
                UserPointModel.fromJson({"uId": userID, "point": 0}),
            userPointState: RequestState.success));
      }
    }).catchError((onError) {
      emit(state.copyWith(
          errorMessage: onError.toString(),
          userPointState: RequestState.error));
    });
  }
}
