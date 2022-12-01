import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gold_line/screens/my_deliveries/my_deliveries.dart';
import 'package:gold_line/screens/request_delivery/sender_details.dart';
import 'package:gold_line/utility/helpers/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class MapWidget extends StatefulWidget {
  final DetailsResult? pickupLocation;
  final DetailsResult? dropoffLocation;

  const MapWidget({Key? key, this.pickupLocation, this.dropoffLocation})
      : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  void initState() {
    // TODO: implement initState
    getPolyPoints();
    super.initState();
  }

  // late CameraPosition _initialPosition;
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

        PointLatLng(widget.pickupLocation!.geometry!.location!.lat!,
            widget.dropoffLocation!.geometry!.location!.lng!),
        PointLatLng(widget.pickupLocation!.geometry!.location!.lat!,
            widget.dropoffLocation!.geometry!.location!.lng!),
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

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(currentLocation!.latitude, currentLocation!.longitude),
      ),
      Marker(
          markerId: MarkerId('start'),
          position: LatLng(widget.pickupLocation!.geometry!.location!.lat!,
              widget.pickupLocation!.geometry!.location!.lng!)),
      Marker(
          markerId: MarkerId('end'),
          position: LatLng(widget.dropoffLocation!.geometry!.location!.lat!,
              widget.dropoffLocation!.geometry!.location!.lng!))
    };
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
                        zoom: 13.5,
                      ),
                      markers: _markers,
                      onMapCreated: (mapController) {
                        _controller.complete(mapController);
                      },
                      polylines: Set<Polyline>.of(polylines.values),

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
                                          onPressed: () {},
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
                                                        const SenderDeliveryDetails()));
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
