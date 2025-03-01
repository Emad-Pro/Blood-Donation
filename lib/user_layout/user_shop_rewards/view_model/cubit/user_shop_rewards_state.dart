part of 'user_shop_rewards_cubit.dart';

class UserShopRewardsState extends Equatable {
  const UserShopRewardsState({
    this.medicineRewardsState = RequestState.init,
    this.paymentsState = RequestState.init,
    this.medicineRewardsModel,
    this.medicineRewardsErrorMessage = '',
  });
  final RequestState medicineRewardsState;
  final List<HospitalMedicineRewardsModel>? medicineRewardsModel;
  final String medicineRewardsErrorMessage;
  final RequestState paymentsState;

  UserShopRewardsState copyWith({
    RequestState? medicineRewardsState,
    List<HospitalMedicineRewardsModel>? medicineRewardsModel,
    String? medicineRewardsErrorMessage,
    RequestState? paymentsState,
  }) {
    return UserShopRewardsState(
      medicineRewardsState: medicineRewardsState ?? this.medicineRewardsState,
      medicineRewardsModel: medicineRewardsModel ?? this.medicineRewardsModel,
      paymentsState: paymentsState ?? RequestState.init,
      medicineRewardsErrorMessage:
          medicineRewardsErrorMessage ?? this.medicineRewardsErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        medicineRewardsState,
        medicineRewardsModel,
        medicineRewardsErrorMessage,
        paymentsState
      ];
}
