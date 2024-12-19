import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/locale/app_localiztions.dart';
import 'package:blood_donation/user_layout/user_main/view/pages/user_profile/view/user_main_profile_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../view/pages/user_find/view/user_main_find_screen.dart';
import '../../view/pages/user_home/view/user_main_home_screen.dart';

part 'user_main_state.dart';

class UserMainCubit extends Cubit<UserMainState> {
  UserMainCubit() : super(UserMainState());
  final List<Widget> screens = [
    UserMainHomeScreen(),
    UserMainProfileScreen(),
    UserMainFindScreen(),
  ];
  final List<String> titles = ["Home", "Profile", "Find Hospital"];

  List<BottomNavyBarItem> items(BuildContext context) => [
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text("Home".tr(context)),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text("Profile".tr(context)),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.search),
          title: Text("Find Hospital".tr(context)),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ];

  toggleBottomNavyBar(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
