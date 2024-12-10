// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_hospital_view_details_cubit.dart';

class UserHospitalViewDetailsState extends Equatable {
  const UserHospitalViewDetailsState({
    this.loadWebViewstState = RequestState.init,
  });
  final RequestState loadWebViewstState;
  @override
  List<Object> get props => [loadWebViewstState];

  UserHospitalViewDetailsState copyWith({
    RequestState? loadWebViewstState,
  }) {
    return UserHospitalViewDetailsState(
      loadWebViewstState: loadWebViewstState ?? this.loadWebViewstState,
    );
  }
}
