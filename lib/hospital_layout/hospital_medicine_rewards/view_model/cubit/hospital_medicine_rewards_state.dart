part of 'hospital_medicine_rewards_cubit.dart';

class HospitalMedicineRewardsState extends Equatable {
  const HospitalMedicineRewardsState({
    this.getMedicineRewardsErrorMessage = '',
    this.getMedicineRewardsModel,
    this.getMedicineRewardsState = RequestState.init,
    this.updateMedicineRewardsState = RequestState.init,
    this.updateMedicineRewardsErrorMessage = '',
    this.deleteMedicineRewardsState = RequestState.init,
    this.deleteMedicineRewardsErrorMessage = '',
    this.addMedicineRewardsState = RequestState.init,
    this.addMedicineRewardsErrorMessage = '',
  });
  final RequestState getMedicineRewardsState;
  final List<HospitalMedicineRewardsModel>? getMedicineRewardsModel;
  final String getMedicineRewardsErrorMessage;

  final RequestState updateMedicineRewardsState;
  final String updateMedicineRewardsErrorMessage;
  final RequestState deleteMedicineRewardsState;
  final String deleteMedicineRewardsErrorMessage;
  final RequestState addMedicineRewardsState;
  final String addMedicineRewardsErrorMessage;

  HospitalMedicineRewardsState copyWith(
      {RequestState? getMedicineRewardsState,
      List<HospitalMedicineRewardsModel>? getMedicineRewardsModel,
      String? getMedicineRewardsErrorMessage,
      RequestState? updateMedicineRewardsState,
      String? updateMedicineRewardsErrorMessage,
      RequestState? deleteMedicineRewardsState,
      String? deleteMedicineRewardsErrorMessage,
      RequestState? addMedicineRewardsState,
      String? addMedicineRewardsErrorMessage}) {
    return HospitalMedicineRewardsState(
      getMedicineRewardsState:
          getMedicineRewardsState ?? this.getMedicineRewardsState,
      getMedicineRewardsModel:
          getMedicineRewardsModel ?? this.getMedicineRewardsModel,
      getMedicineRewardsErrorMessage:
          getMedicineRewardsErrorMessage ?? this.getMedicineRewardsErrorMessage,
      updateMedicineRewardsState:
          updateMedicineRewardsState ?? RequestState.init,
      updateMedicineRewardsErrorMessage: updateMedicineRewardsErrorMessage ??
          this.updateMedicineRewardsErrorMessage,
      deleteMedicineRewardsState:
          deleteMedicineRewardsState ?? RequestState.init,
      deleteMedicineRewardsErrorMessage: deleteMedicineRewardsErrorMessage ??
          this.deleteMedicineRewardsErrorMessage,
      addMedicineRewardsState: addMedicineRewardsState ?? RequestState.init,
      addMedicineRewardsErrorMessage:
          addMedicineRewardsErrorMessage ?? this.addMedicineRewardsErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        getMedicineRewardsState,
        getMedicineRewardsModel,
        getMedicineRewardsErrorMessage,
        updateMedicineRewardsState,
        updateMedicineRewardsErrorMessage,
        deleteMedicineRewardsState,
        deleteMedicineRewardsErrorMessage,
        addMedicineRewardsState,
        addMedicineRewardsErrorMessage
      ];
}
