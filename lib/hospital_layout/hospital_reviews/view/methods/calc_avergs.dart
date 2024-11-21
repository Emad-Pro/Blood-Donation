import '../../model/hospital_review_model.dart';

double calculateAverageRating(List<HospitalReviewModel> reviews) {
  if (reviews.isEmpty) {
    return 0.0;
  }

  double sum =
      reviews.fold(0.0, (previous, current) => previous + current.rating!);

  double average = sum / reviews.length;

  // تأكد من أن المتوسط يقع بين 0 و 5
  return average > 5 ? 5.0 : (average < 0 ? 0.0 : average);
}
