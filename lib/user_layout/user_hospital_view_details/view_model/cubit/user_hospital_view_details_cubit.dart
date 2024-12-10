import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blood_donation/core/enum/request_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'user_hospital_view_details_state.dart';

class UserHospitalViewDetailsCubit extends Cubit<UserHospitalViewDetailsState> {
  UserHospitalViewDetailsCubit() : super(UserHospitalViewDetailsState());
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();
  CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  initWebView() {
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    Future<void> _goToTheLake() async {
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
    }
  }
}
