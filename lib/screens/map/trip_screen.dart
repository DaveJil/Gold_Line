import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gold_line/screens/my_deliveries/my_deliveries.dart';
import 'package:gold_line/screens/profile/main_menu.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../request_delivery/delivery_details.dart';

class TestMapWidget extends StatefulWidget {
  const TestMapWidget({Key? key}) : super(key: key);

  @override
  State<TestMapWidget> createState() => _TestMapWidgetState();
}

class _TestMapWidgetState extends State<TestMapWidget> {
  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    getPolyPoints();
    super.initState();
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY, // Your Google Map Key
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  LatLng? currentLocation;
  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
    return;
  }

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
        .then(
      (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_destination.png")
        .then(
      (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Badge.png")
        .then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: Text("Loading"))
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: currentLocation!,
                        zoom: 30,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("currentLocation"),
                          position: LatLng(currentLocation!.latitude,
                              currentLocation!.longitude),
                        ),
                        Marker(
                            markerId: MarkerId("source"),
                            position: LatLng(currentLocation!.latitude,
                                currentLocation!.longitude),
                            icon: currentLocationIcon),
                        Marker(
                            markerId: MarkerId("destination"),
                            position: destination,
                            icon: destinationIcon),
                      },
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("route"),
                          points: polylineCoordinates,
                          color: const Color(0xFF7B61FF),
                          width: 6,
                        ),
                      },
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 80,
                          width: double.infinity,
                          color: kVistaWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const MainMenu()));
                                          },
                                          icon: const Icon(
                                            Icons.home_outlined,
                                            color: kPrimaryGoldColor,
                                            size: 40,
                                          ),
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      const Text(
                                        "Main Menu",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const DeliveryDetails()));
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: kPrimaryGoldColor,
                                            size: 40,
                                          ),
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      const Text(
                                        "New Delivery",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const MyDeliveriesScreen()));
                                          },
                                          icon: const Icon(
                                            Icons.history,
                                            color: kPrimaryGoldColor,
                                            size: 40,
                                          ),
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      const Text(
                                        "My Deliveries",
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
    );
  }
}
