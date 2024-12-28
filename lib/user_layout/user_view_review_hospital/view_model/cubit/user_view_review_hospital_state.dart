// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_view_review_hospital_cubit.dart';

class UserViewReviewHospitalState extends Equatable {
  final RequestState reviewsState;
  final List<HospitalReviewModel>? hospitalReviewModel;
  final String errorMessage;
  final RequestState addReviewState;
  final double currentRating;
  UserViewReviewHospitalState(
      {this.reviewsState = RequestState.init,
      this.hospitalReviewModel,
      this.errorMessage = "",
      this.addReviewState = RequestState.init,
      this.currentRating = 0.0});
  @override
  List<Object?> get props => [
        reviewsState,
        hospitalReviewModel,
        errorMessage,
        addReviewState,
        currentRating
      ];

  UserViewReviewHospitalState copyWith(
      {RequestState? reviewsState,
      List<HospitalReviewModel>? hospitalReviewModel,
      String? errorMessage,
      RequestState? addReviewState,
      double? currentRating}) {
    return UserViewReviewHospitalState(
        reviewsState: reviewsState ?? this.reviewsState,
        hospitalReviewModel: hospitalReviewModel ?? this.hospitalReviewModel,
        errorMessage: errorMessage ?? this.errorMessage,
        addReviewState: addReviewState ?? RequestState.init,
        currentRating: currentRating ?? this.currentRating);
  }
}
