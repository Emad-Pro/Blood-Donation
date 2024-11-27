part of 'hospital_home_cubit.dart';

class HospitalHomeState extends Equatable {
  final RequestState reviewsSliderState;
  final List<String>? listReviewsSlider;
  final String errorReviewsSliderMessage;
  final String recentDontionsMessage;
  final List<HospitalDonationsModel>? hospitalDonationsModel;
  final RequestState hospitalDonationsState;

  HospitalHomeState(
      {this.reviewsSliderState = RequestState.init,
      this.listReviewsSlider,
      this.errorReviewsSliderMessage = '',
      this.recentDontionsMessage = '',
      this.hospitalDonationsModel,
      this.hospitalDonationsState = RequestState.init});

  @override
  List<Object?> get props => [
        reviewsSliderState,
        listReviewsSlider,
        errorReviewsSliderMessage,
        recentDontionsMessage,
        hospitalDonationsModel,
        hospitalDonationsState
      ];

  HospitalHomeState copyWith(
      {RequestState? reviewsSliderState,
      List<String>? listReviewsSlider,
      String? errorReviewsSliderMessage,
      String? recentDontionsMessage,
      List<HospitalDonationsModel>? hospitalDonationsModel,
      RequestState? hospitalDonationsState}) {
    return HospitalHomeState(
        reviewsSliderState: reviewsSliderState ?? this.reviewsSliderState,
        listReviewsSlider: listReviewsSlider ?? this.listReviewsSlider,
        errorReviewsSliderMessage:
            errorReviewsSliderMessage ?? this.errorReviewsSliderMessage,
        recentDontionsMessage:
            recentDontionsMessage ?? this.recentDontionsMessage,
        hospitalDonationsModel:
            hospitalDonationsModel ?? this.hospitalDonationsModel,
        hospitalDonationsState:
            hospitalDonationsState ?? this.hospitalDonationsState);
  }
}
