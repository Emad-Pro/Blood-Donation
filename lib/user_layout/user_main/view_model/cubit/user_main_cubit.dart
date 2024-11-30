import 'package:bloc/bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'user_main_state.dart';

class UserMainCubit extends Cubit<UserMainState> {
  UserMainCubit() : super(UserMainState());
  final List<Widget> screens = [
    Text("Home"),
    Text("Profile"),
    Text("Find Hospital"),
  ];

  final List<BottomNavyBarItem> items = [
    BottomNavyBarItem(
      icon: Icon(Icons.home),
      title: Text("Home"),
      activeColor: Colors.black,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.person),
      title: Text("Profile"),
      activeColor: Colors.black,
    ),
    BottomNavyBarItem(
      icon: Icon(Icons.search),
      title: Text("Find Hospital"),
      activeColor: Colors.black,
    ),
  ];

  toggleBottomNavyBar(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
