// File for class HospitalHomeSlider

import 'package:blood_donation/core/auto_direction.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:blood_donation/hospital_layout/hospital_main/pages/hospital_home_screen/view_model/cubit/hospital_home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/di/service_lacator.dart';

class HospitalHomeSlider extends StatelessWidget {
  const HospitalHomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalHomeCubit, HospitalHomeState>(
      bloc: getIt<HospitalHomeCubit>()..getHospitalReviews(),
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              height: state.listReviewsSlider != null &&
                      state.listReviewsSlider!.length != 0
                  ? 200
                  : 0,
              child: Builder(builder: (context) {
                print(state.listReviewsSlider);
                switch (state.reviewsSliderState) {
                  case RequestState.init:
                  case RequestState.loading:
                    return Center(child: CircularProgressIndicator());
                  case RequestState.error:
                    return Center(child: Text(state.errorReviewsSliderMessage));
                  case RequestState.success:
                    return state.listReviewsSlider != null &&
                            state.listReviewsSlider!.length != 0
                        ? CarouselSlider.builder(
                            options: CarouselOptions(
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                            ),
                            itemCount: state.listReviewsSlider!.isNotEmpty
                                ? state.listReviewsSlider!.length
                                : [].length,
                            itemBuilder: (context, index, inde) {
                              return Card(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.2,
                                          "assets/images/hospital_images/slider${1 + index}.png"),
                                      Expanded(
                                        child: AutoDirection(
                                          text: state.listReviewsSlider![index],
                                          child: Text(
                                            "'${state.listReviewsSlider![index]}'",
                                            maxLines: 5,
                                            // textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container();
                }
              })),
        );
      },
    );
  }
}
