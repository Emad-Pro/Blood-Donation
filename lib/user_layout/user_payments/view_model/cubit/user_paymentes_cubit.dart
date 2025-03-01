import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/enum/request_state.dart';
import '../../model/user_payments_model.dart';

part 'user_paymentes_state.dart';

class UserPaymentesCubit extends Cubit<UserPaymentesState> {
  UserPaymentesCubit() : super(UserPaymentesState());

  void getPayments() async {
    emit(state.copyWith(getPaymentsState: RequestState.loading));
    final SupabaseClient supabase = Supabase.instance.client;
    try {
      final response = await supabase
          .from('payments')
          .select('*,HospitalAuth(*)')
          .eq("user_uId", supabase.auth.currentUser!.id);

      emit(state.copyWith(
          getPaymentsState: RequestState.success,
          paymentsModel:
              response.map((e) => UserPaymentsModel.fromJson(e)).toList()));
    } on PostgrestException catch (e) {
      print(e);
      emit(state.copyWith(
        getPaymentsState: RequestState.error,
      ));
    } on SocketException catch (e) {
      print(e);
      emit(state.copyWith(
        getPaymentsState: RequestState.error,
      ));
    }
  }
}
