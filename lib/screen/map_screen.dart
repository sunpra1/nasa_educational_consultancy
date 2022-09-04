import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {

  static const routeName = "/mapScreen";

  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  double lat = 27.750165405127756;
  double lng = 85.3607682;

  final Completer<GoogleMapController> _controller = Completer();

  late CameraPosition cameraPosition = CameraPosition(
    target: LatLng(lat, lng),
    zoom: 16.0,
  );

  late final Set<Marker> _markers = {
    Marker(
      markerId: const MarkerId('id-1'),
      position: LatLng(lat, lng),
      infoWindow: const InfoWindow(
        title: "Location Name",
        snippet: "Location Description",
      ),
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          gestureRecognizers: {
            Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
            ),
          },
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
          mapType: MapType.normal,
          markers: _markers,
          initialCameraPosition: cameraPosition,
        ),
      ),
    );
  }
}
