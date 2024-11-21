// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hospital_review_cubit.dart';

class HospitalReviewState extends Equatable {
  final RequestState reviewsState;
  final List<HospitalReviewModel>? hospitalReviewModel;
  final String errorMessage;

  HospitalReviewState(
      {this.reviewsState = RequestState.init,
      this.hospitalReviewModel,
      this.errorMessage = ''});

  @override
  List<Object?> get props => [errorMessage, reviewsState, hospitalReviewModel];

  HospitalReviewState copyWith({
    RequestState? reviewsState,
    List<HospitalReviewModel>? hospitalReviewModel,
    String? errorMessage,
  }) {
    return HospitalReviewState(
      reviewsState: reviewsState ?? this.reviewsState,
      hospitalReviewModel: hospitalReviewModel ?? this.hospitalReviewModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
