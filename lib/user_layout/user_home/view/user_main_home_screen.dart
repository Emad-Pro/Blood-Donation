import 'package:blood_donation/user_layout/user_home/view_model/cubit/user_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/service_lacator.dart';
import 'widget/user_main_home_carousel_widget.dart';
import 'widget/user_main_home_points_widget.dart';
import 'widget/user_main_list_view_blood_type.dart';
import 'widget/user_main_title_text.dart';

class UserMainHomeScreen extends StatelessWidget {
  const UserMainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: BlocBuilder<UserHomeCubit, UserHomeState>(
          bloc: getIt<UserHomeCubit>()..getUserPoints(),
          builder: (context, state) {
            return Column(children: [
              UserMainHomePointsWidget(),
              UserMainTitleText(
                  title: "The Benefits and Conditions of Blood Donation"),
              UserMainHomeCarouselWidget(),
              UserMainTitleText(title: "Read About Blood Donation Types"),
              UserMainListViewBloodType()
            ]);
          },
        ),
      ),
    );
  }
}
