import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gold_line/screens/my_deliveries/my_deliveries.dart';
import 'package:gold_line/screens/profile/main_menu.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:gold_line/utility/services/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utility/map_utils.dart';
import '../request_delivery/delivery_details.dart';

class MapWidget extends StatefulWidget {
  final LatLng? pickupLatLng;
  final LatLng? dropoffLatLng;

  const MapWidget({Key? key, this.pickupLatLng, this.dropoffLatLng})
      : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  void initState() {
    // TODO: implement initState
    getPolyPoints();
    getCurrentLocation();
    _initialPosition = CameraPosition(
      target: widget.pickupLatLng!,
      zoom: 30,
    );
    super.initState();
  }

  CameraPosition? _initialPosition;
  LocationService locationService = LocationService();
  final Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polylineCoordinates,
        width: 1);
    polylines[id] = polyline;
    setState(() {});
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GOOGLE_MAPS_API_KEY,
        // Your Google Map Key

        PointLatLng(
            widget.pickupLatLng!.latitude, widget.pickupLatLng!.longitude),
        PointLatLng(
            widget.dropoffLatLng!.latitude, widget.dropoffLatLng!.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
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

  LatLng? currentLocation;
  Future<LatLng?> getCurrentLocation() async {
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

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        forceAndroidLocationManager: true);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
    return currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(markerId: MarkerId('start'), position: widget.pickupLatLng!),
      Marker(markerId: MarkerId('end'), position: widget.dropoffLatLng!)
    };
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Stack(
            children: [
              GoogleMap(
                polylines: Set<Polyline>.of(polylines.values),
                initialCameraPosition: _initialPosition!,
                markers: Set.from(_markers),
                onMapCreated: (GoogleMapController controller) {
                  Future.delayed(Duration(milliseconds: 2000), () {
                    controller.animateCamera(CameraUpdate.newLatLngBounds(
                        MapUtils.boundsFromLatLngList(
                            _markers.map((loc) => loc.position).toList()),
                        1));
                    getPolyPoints();
                  });
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
                                              builder: (_) => MainMenu()));
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
