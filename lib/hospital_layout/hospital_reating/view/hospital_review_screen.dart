import 'package:blood_donation/hospital_layout/hospital_reating/view_model/cubit/hospital_review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/request_state.dart';
import 'widget/hospital_profile_review_build_card.dart';
import 'widget/hospital_profile_review_header_widget.dart';

class HospitalReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return BlocProvider(
      create: (context) => HospitalReviewCubit(),
      child: Scaffold(
        appBar: AppBar(
          //      backgroundColor: primaryColor,
          title: Text("Hospital Name"),
        ),
        body: BlocBuilder<HospitalReviewCubit, HospitalReviewState>(
          builder: (context, state) {
            switch (state.reviewsState) {
              case RequestState.init:
              case RequestState.loading:
                return Center(child: CircularProgressIndicator());
              case RequestState.success:
                return SingleChildScrollView(
                  //    physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HospitalProfileReviewHeaderWidget(state: state),
                      SizedBox(
                        child: ListView.builder(
                            itemCount: state.hospitalReviewModel!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return HospitalProfileReviewBuildCard(
                                rating:
                                    state.hospitalReviewModel![index].rating!,
                                name:
                                    state.hospitalReviewModel![index].userName!,
                                text: state.hospitalReviewModel![index].review!,
                                bloodType: state
                                    .hospitalReviewModel![index].userBloodType!,
                              );
                            }),
                      )
                    ],
                  ),
                );
              case RequestState.error:
                return Center(child: Text(state.errorMessage!));
            }
          },
        ),
      ),
    );
  }
}
