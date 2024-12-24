import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen(
      {Key? key, required this.longitude, required this.latitude})
      : super(key: key);
  final double longitude;
  final double latitude;

  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  late GoogleMapController mapController;
  late LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    // تعيين خط الطول والعرض
    _initialPosition = LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _initialPosition,
        zoom: 12.0, // مستوى التكبير
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      markers: {
        Marker(
          markerId: MarkerId('targetLocation'),
          position: _initialPosition,
          infoWindow: InfoWindow(
            title: 'الموقع',
            snippet: 'الوصف هنا',
          ),
        ),
      },
    );
  }
}
