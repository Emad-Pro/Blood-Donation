import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_view_review_hospital/view_model/cubit/user_view_review_hospital_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserAddReviewInHospitalScreen extends StatelessWidget {
  final UserViewReviewHospitalCubit cubit;
  final String hospitalUid;
  const UserAddReviewInHospitalScreen(
      {Key? key, required this.cubit, required this.hospitalUid});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.copyWith(left: 7, right: 7),
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Text(
                "Add Review".tr(context),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary),
              ),
              RatingBar.builder(
                initialRating: cubit.state.currentRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  cubit.changeReatingValue(rating);
                },
              ),
              SizedBox(height: 20),
              // Review Input

              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your review'.tr(context);
                  }
                  return null;
                },
                controller: cubit.reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your review here...'.tr(context),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.addReview(hospitalUid);
                    }
                    ;
                  },
                  child: Text('Submit Review'.tr(context)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
