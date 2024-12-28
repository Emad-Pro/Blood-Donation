import 'package:blood_donation/hospital_layout/hospital_reviews/view_model/cubit/hospital_review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/request_state.dart';
import 'widget/hospital_profile_review_build_card.dart';
import 'widget/hospital_profile_review_header_widget.dart';

class HospitalReviewScreen extends StatelessWidget {
  final String hospitalName;
  const HospitalReviewScreen({Key? key, required this.hospitalName});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalReviewCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(hospitalName),
        ),
        body: BlocBuilder<HospitalReviewCubit, HospitalReviewState>(
          builder: (context, state) {
            final cubit = context.read<HospitalReviewCubit>();
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
                      HospitalProfileReviewHeaderWidget(
                        state: state,
                        cubit: cubit,
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
                );
              case RequestState.error:
                return Center(child: Text(state.errorMessage));
            }
          },
        ),
      ),
    );
  }
}
