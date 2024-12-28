import '../../hospital_layout/hospital_reviews/model/hospital_review_model.dart';

Map<int, int> calculateRatingsDistribution(
    List<HospitalReviewModel>? hospitalReviewModel) {
  Map<int, int> distribution = {
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
  };

  // تمرير جميع التقييمات وتحديث التوزيع
  for (HospitalReviewModel rating in hospitalReviewModel!) {
    if (distribution.containsKey(rating.rating!.toInt())) {
      distribution[rating.rating!.toInt()] =
          distribution[rating.rating!.toInt()]! + 1;
    }
  }

  return distribution;
}
