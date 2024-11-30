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
      appBar: AppBar(title: Text("User Main Screen")),
      body: BlocBuilder<UserMainCubit, UserMainState>(
          bloc: getIt<UserMainCubit>(),
          builder: (context, state) {
            return getIt<UserMainCubit>().screens[state.currentIndex];
          }),
      bottomNavigationBar: BlocBuilder<UserMainCubit, UserMainState>(
        bloc: getIt<UserMainCubit>(),
        builder: (context, state) {
          return BottomNavyBar(
              items: getIt<UserMainCubit>().items,
              selectedIndex: state.currentIndex,
              onItemSelected: (index) {
                getIt<UserMainCubit>().toggleBottomNavyBar(index);
              });
        },
      ),
    );
  }
}
