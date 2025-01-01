import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_lacator.dart';
import '../view_model/cubit/user_main_cubit.dart';

class UserMainScreen extends StatelessWidget {
  const UserMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UserMainCubit, UserMainState>(
          bloc: getIt<UserMainCubit>(),
          builder: (context, state) {
            return Text(
              getIt<UserMainCubit>().titles[state.currentIndex].tr(context),
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            );
          },
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.notifications_active_outlined,
          //     color: Theme.of(context).colorScheme.primary,
          //   ),
          // )
        ],
      ),
      body: BlocBuilder<UserMainCubit, UserMainState>(
          bloc: getIt<UserMainCubit>(),
          builder: (context, state) {
            return getIt<UserMainCubit>().screens[state.currentIndex];
          }),
      bottomNavigationBar: BlocBuilder<UserMainCubit, UserMainState>(
        bloc: getIt<UserMainCubit>(),
        builder: (context, state) {
          return BottomNavyBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              items: getIt<UserMainCubit>().items(context),
              selectedIndex: state.currentIndex,
              onItemSelected: (index) {
                getIt<UserMainCubit>().toggleBottomNavyBar(index);
              });
        },
      ),
    );
  }
}
