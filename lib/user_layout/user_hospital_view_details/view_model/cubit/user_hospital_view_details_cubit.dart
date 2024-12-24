import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:equatable/equatable.dart';

part 'user_hospital_view_details_state.dart';

class UserHospitalViewDetailsCubit extends Cubit<UserHospitalViewDetailsState> {
  UserHospitalViewDetailsCubit() : super(UserHospitalViewDetailsState());
}
