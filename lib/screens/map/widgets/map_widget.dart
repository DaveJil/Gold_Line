import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: sourceLocation,
        zoom: 13.5,
      ),

      // onMapCreated: mapProvider.onCreate,
      myLocationEnabled: true,
      mapType: MapType.normal,
      compassEnabled: true,
      rotateGesturesEnabled: true,
      // markers: mapProvider.markers,
      // onCameraMove: mapProvider.onCameraMove,
      // polylines: mapProvider.poly,
      markers: {
        const Marker(
          markerId: MarkerId("source"),
          position: sourceLocation,
        ),
        const Marker(
          markerId: MarkerId("destination"),
          position: destination,
        ),
      },
      onMapCreated: (mapController) {
        _controller.complete(mapController);
      },
    );
  }
}
