part of 'user_paymentes_cubit.dart';

class UserPaymentesState extends Equatable {
  const UserPaymentesState({
    this.getPaymentsState = RequestState.init,
    this.paymentsModel,
  });
  final RequestState getPaymentsState;
  final List<UserPaymentsModel>? paymentsModel;

  UserPaymentesState copyWith({
    RequestState? getPaymentsState,
    List<UserPaymentsModel>? paymentsModel,
  }) {
    return UserPaymentesState(
      getPaymentsState: getPaymentsState ?? this.getPaymentsState,
      paymentsModel: paymentsModel ?? this.paymentsModel,
    );
  }

  @override
  List<Object?> get props => [getPaymentsState, paymentsModel];
}
