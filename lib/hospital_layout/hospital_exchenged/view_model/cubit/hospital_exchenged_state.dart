part of 'hospital_exchenged_cubit.dart';

class HospitalExchengedState extends Equatable {
  const HospitalExchengedState({
    this.getExchengedState = RequestState.init,
    this.errorMessage = '',
    this.hospitalExchangedModel,
    this.updateExchengedState = RequestState.init,
  });
  final RequestState getExchengedState;
  final String errorMessage;
  final List<HospitalExchangedModel>? hospitalExchangedModel;
  final RequestState updateExchengedState;
  HospitalExchengedState copyWith(
      {RequestState? getExchengedState,
      String? errorMessage,
      List<HospitalExchangedModel>? hospitalExchangedModel,
      RequestState? updateExchengedState}) {
    return HospitalExchengedState(
        getExchengedState: getExchengedState ?? this.getExchengedState,
        errorMessage: errorMessage ?? this.errorMessage,
        hospitalExchangedModel:
            hospitalExchangedModel ?? this.hospitalExchangedModel,
        updateExchengedState: updateExchengedState ?? RequestState.init);
  }

  @override
  List<Object?> get props => [
        getExchengedState,
        errorMessage,
        hospitalExchangedModel,
        updateExchengedState
      ];
}
