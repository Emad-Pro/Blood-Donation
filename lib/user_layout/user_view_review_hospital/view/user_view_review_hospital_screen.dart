import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/core/widget/global_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rating_summary/rating_summary.dart';

import '../../../core/enum/request_state.dart';
import '../../../core/methods/calculate_reating.dart';
import '../../../hospital_layout/hospital_profile_screen/data/model/hospital_profile_model/hospital_profile_model.dart';
import '../../../hospital_layout/hospital_reviews/view/methods/calc_avergs.dart';
import '../../../hospital_layout/hospital_reviews/view/widget/hospital_profile_review_build_card.dart';
import '../view_model/cubit/user_view_review_hospital_cubit.dart';
import 'user_add_review_in_hospital_screen.dart';

class UserViewReviewHospitalScreen extends StatelessWidget {
  const UserViewReviewHospitalScreen(
      {Key? key, required this.hospitalProfileModel})
      : super(key: key);
  final HospitalProfileModel hospitalProfileModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserViewReviewHospitalCubit()
        ..getReviewsWithUid(hospitalProfileModel.uId!),
      child: BlocConsumer<UserViewReviewHospitalCubit,
          UserViewReviewHospitalState>(
        listener: (context, state) {
          if (state.addReviewState == RequestState.success) {
            globalSnackbar(context, "Review Added Successfully".tr(context),
                backgroundColor: Colors.green);
            Navigator.pop(context);
          } else if (state.addReviewState == RequestState.error) {
            globalSnackbar(context, "Failed To Add Review",
                backgroundColor: Colors.red);
          }
        },
        builder: (context, state) {
          final cubit = context.read<UserViewReviewHospitalCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text("Reviews".tr(context)),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.rate_review,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: false,
                        builder: (context) => UserAddReviewInHospitalScreen(
                            cubit: cubit,
                            hospitalUid: hospitalProfileModel.uId!));
                  },
                )
              ],
            ),
            body: Builder(
              builder: (context) {
                switch (state.reviewsState) {
                  case RequestState.init:
                  case RequestState.loading:
                    return Center(child: CircularProgressIndicator());
                  case RequestState.success:
                    final values =
                        calculateRatingsDistribution(state.hospitalReviewModel!)
                            .values
                            .toList();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${"Ratings & Reviews".tr(context)} (${state.hospitalReviewModel!.length})",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 16),
                                RatingSummary(
                                  color: Theme.of(context).colorScheme.primary,
                                  counter: state.hospitalReviewModel!.length,
                                  average: calculateAverageRating(
                                      state.hospitalReviewModel!),
                                  showAverage: true,
                                  counterFiveStars: values[4],
                                  counterFourStars: values[3],
                                  counterThreeStars: values[2],
                                  counterTwoStars: values[1],
                                  counterOneStars: values[0],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Reviews".tr(context),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                            SizedBox(
                              child: ListView.builder(
                                  itemCount: state.hospitalReviewModel!.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return HospitalProfileReviewBuildCard(
                                      review: state.hospitalReviewModel![index],
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    );
                  case RequestState.error:
                    return Center(
                      child: Text(state.errorMessage),
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
